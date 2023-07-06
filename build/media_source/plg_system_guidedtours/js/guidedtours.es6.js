/**
 * @copyright   (C) 2023 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

import Shepherd from 'shepherd.js';

if (!Joomla) {
  throw new Error('Joomla API is not properly initialised');
}

function emptyStorage() {
  sessionStorage.removeItem('currentStepId');
  sessionStorage.removeItem('stepCount');
  sessionStorage.removeItem('tourId');
  sessionStorage.removeItem('tourToken');
  sessionStorage.removeItem('previousStepUrl');
}

function getTourInstance() {
  const tour = new Shepherd.Tour({
    defaultStepOptions: {
      cancelIcon: {
        enabled: true,
        label: Joomla.Text._('JCANCEL'),
      },
      classes: 'shepherd-theme-arrows',
      scrollTo: {
        behavior: 'smooth',
        block: 'center',
      },
    },
    useModalOverlay: true,
    keyboardNavigation: true,
  });

  tour.on('cancel', () => {
    emptyStorage();

    tour.steps = [];
  });

  return tour;
}

function addProgressIndicator(stepElement, index, total) {
  const header = stepElement.querySelector('.shepherd-header');
  const progress = document.createElement('div');
  progress.classList.add('shepherd-progress');
  progress.setAttribute('role', 'status');
  progress.setAttribute('aria-label', Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_STEP_NUMBER_OF').replace('{number}', index).replace('{total}', total));
  const progressText = document.createElement('span');
  progressText.setAttribute('aria-hidden', true);
  progressText.innerText = `${index}/${total}`;
  progress.appendChild(progressText);
  header.insertBefore(progress, stepElement.querySelector('.shepherd-cancel-icon'));
}

function setFocus(primaryButton, secondaryButton, cancelButton) {
  if (primaryButton && !primaryButton.disabled) {
    primaryButton.focus();
  } else if (secondaryButton && !secondaryButton.disabled) {
    secondaryButton.focus();
  } else {
    cancelButton.focus();
  }
}

function enableButton(eventElement) {
  const element = eventElement instanceof Event ? document.querySelector(`.step-next-button-${eventElement.currentTarget.step_id}`) : eventElement;
  element.removeAttribute('disabled');
  element.classList.remove('disabled');
}
function disableButton(eventElement) {
  const element = eventElement instanceof Event ? document.querySelector(`.step-next-button-${eventElement.currentTarget.step_id}`) : eventElement;
  element.setAttribute('disabled', 'disabled');
  element.classList.add('disabled');
}

function addStepToTourButton(tour, stepObj, buttons) {
  const step = new Shepherd.Step(tour, {
    title: stepObj.title,
    text: stepObj.description,
    classes: 'shepherd-theme-arrows',
    buttons,
    id: stepObj.id,
    arrow: true,
    params: stepObj.params,
    beforeShowPromise() {
      return new Promise((resolve) => {
        // Set graceful fallbacks in case there is an issue with the target.
        // Possibility to use comma-separated selectors.
        if (tour.currentStep.options.attachTo.element) {
          const targets = tour.currentStep.options.attachTo.element.split(',');
          const position = tour.currentStep.options.attachTo.on;
          tour.currentStep.options.attachTo.element = '';
          tour.currentStep.options.attachTo.on = 'center';

          for (let i = 0; i < targets.length; i += 1) {
            const t = document.querySelector(targets[i]);
            if (t != null) {
              if (!t.disabled && !t.readonly && t.style.display !== 'none') {
                tour.currentStep.options.attachTo.element = targets[i];
                tour.currentStep.options.attachTo.on = position;
                break;
              }
            }
          }
        }
        if (tour.currentStep.options.attachTo.type === 'redirect') {
          const stepUrl = Joomla.getOptions('system.paths').rootFull + tour.currentStep.options.attachTo.url;
          if (window.location.href !== stepUrl) {
            sessionStorage.setItem('currentStepId', tour.currentStep.id);
            sessionStorage.setItem('previousStepUrl', window.location.href);
            window.location.href = stepUrl;
          } else {
            resolve();
          }
        } else {
          resolve();
        }
      }).catch(() => {
        // Ignore
      });
    },
    when: {
      show() {
        const element = this.getElement();
        const target = this.getTarget();

        // if target element doesn't exist e.g. because we have navigated to a new page mid-tour then end the tour here!
        // Take care though since some steps have no target to we check for these too
        if (!target && this.options.attachTo.element) {
          emptyStorage();
          this.cancel();
          return;
        }

        // Force the screen reader to only read the content of the popup after a refresh
        element.setAttribute('aria-live', 'assertive');

        sessionStorage.setItem('currentStepId', this.id);
        addProgressIndicator(element, this.id + 1, sessionStorage.getItem('stepCount'));

        if (target && this.options.attachTo.type === 'interactive') {
          const cancelButton = element.querySelector('.shepherd-cancel-icon');
          const primaryButton = element.querySelector('.shepherd-button-primary');
          const secondaryButton = element.querySelector('.shepherd-button-secondary');

          // Check to see if the 'next' button should be enabled before showing the step based on being required or
          // matching the required value
          switch (this.options.attachTo.interactive_type) {
            case 'text':
              if (
                (target.hasAttribute('required') || (this.options.params.required || 0))
                && (
                  (target.tagName.toLowerCase() === 'input' && ['email', 'password', 'search', 'tel', 'text', 'url'].includes(target.type))
                    || target.tagName.toLowerCase() === 'textarea'
                )
              ) {
                if ((this.options.params.requiredvalue || '') !== '') {
                  if (target.value.trim() === this.options.params.requiredvalue) {
                    enableButton(primaryButton);
                  } else {
                    disableButton(primaryButton);
                  }
                } else if (target.value.trim().length) {
                  enableButton(primaryButton);
                } else {
                  disableButton(primaryButton);
                }
              }
              break;

            case 'checkbox_radio':
              if (
                target.tagName.toLowerCase() === 'input'
                && (target.hasAttribute('required') || (this.options.params.required || 0))
                && ['checkbox', 'radio'].includes(target.type)
              ) {
                if (target.checked) {
                  enableButton(primaryButton);
                } else {
                  disableButton(primaryButton);
                }
              }
              break;

            case 'select':
              if (
                target.tagName.toLowerCase() === 'select'
                && (target.hasAttribute('required') || (this.options.params.required || 0))
              ) {
                if ((this.options.params.requiredvalue || '') !== '') {
                  if (target.value.trim() === this.options.params.requiredvalue) {
                    enableButton(primaryButton);
                  } else {
                    disableButton(primaryButton);
                  }
                } else if (target.value.trim().length) {
                  enableButton(primaryButton);
                } else {
                  disableButton(primaryButton);
                }
              }
              break;

            default:
              break;
          }

          cancelButton.addEventListener('keydown', (event) => {
            if (event.key === 'Tab') {
              if (target.tagName.toLowerCase() === 'joomla-field-fancy-select') {
                target.querySelector('.choices').click();
                target.querySelector('.choices input').focus();
              } else if (target.parentElement.tagName.toLowerCase() === 'joomla-field-fancy-select') {
                target.click();
                target.querySelector('input').focus();
              } else {
                target.focus();
                event.preventDefault();
              }
            }
          });

          if (target.tagName.toLowerCase() === 'iframe') {
            // Give blur to the content of the iframe, as iframes don't have blur events
            target.contentWindow.document.body.addEventListener('blur', (event) => {
              if (!sessionStorage.getItem('tourId')) {
                return;
              }
              setTimeout(() => {
                setFocus(primaryButton, secondaryButton, cancelButton);
              }, 1);
              event.preventDefault();
            });
          } else if (target.tagName.toLowerCase() === 'joomla-field-fancy-select') {
            target.querySelector('.choices input').addEventListener('blur', (event) => {
              if (!sessionStorage.getItem('tourId')) {
                return;
              }
              setFocus(primaryButton, secondaryButton, cancelButton);
              event.preventDefault();
            });
          } else if (target.parentElement.tagName.toLowerCase() === 'joomla-field-fancy-select') {
            target.querySelector('input').addEventListener('blur', (event) => {
              if (!sessionStorage.getItem('tourId')) {
                return;
              }
              setFocus(primaryButton, secondaryButton, cancelButton);
              event.preventDefault();
            });
          } else {
            target.addEventListener('blur', (event) => {
              if (!sessionStorage.getItem('tourId')) {
                return;
              }
              setFocus(primaryButton, secondaryButton, cancelButton);
              event.preventDefault();
            });
          }

          let focusTarget = target;
          if (
            ((this.options.params.customfocustarget || 0) === 1)
            && ((this.options.params.focustarget || '') !== '')
          ) {
            focusTarget = document.querySelector(this.options.params.focustarget);
          }

          const gtShowStep = new CustomEvent('guided-tour-show-step', {
            detail: {
              stepObj,
            },
            bubbles: true,
            tourId: sessionStorage.getItem('tourId'),
          });
          focusTarget.dispatchEvent(gtShowStep);

          // Set focus on input box after the tour step has finished rendering and positioning
          // Timeout has to be more than 300 since the setPosition method has a 300 millisecond delay
          setTimeout(() => {
            // eslint-disable-next-line no-constant-condition
            if (this.options.params.setfocus || 1) {
              focusTarget.focus();
            }

            const onDisplayEvents = stepObj.params.ondisplayevents || {};

            Object.values(onDisplayEvents).forEach((displayEvent) => {
              let eventElement = onDisplayEvents[displayEvent].ondisplayeventelement;
              const eventsToTrigger = onDisplayEvents[displayEvent].ondisplayevent;
              if (eventElement !== '' && eventsToTrigger.length > 0) {
                eventElement = document.querySelector(eventElement);
                if (eventElement) {
                  eventsToTrigger.forEach((eventName) => {
                    // console.log(`firing event ${eventName}`);
                    const event = new MouseEvent(eventName, {
                      view: window,
                      bubbles: true,
                      cancelable: true,
                    });
                    eventElement.dispatchEvent(event);
                  });
                }
              }
            });

            const gtFocusStep = new CustomEvent('guided-tour-step-focussed', {
              detail: {
                stepObj,
              },
              bubbles: true,
              tourId: sessionStorage.getItem('tourId'),
            });
            focusTarget.dispatchEvent(gtFocusStep);
          }, 350);
        } else if (this.options.attachTo.type === 'next') {
          // Still need to fire the onDisplayEvents
          setTimeout(() => {
            if (typeof stepObj.params === 'string' && stepObj.params !== '') {
              stepObj.params = JSON.parse(stepObj.params);
            } else {
              stepObj.params = [];
            }

            const onDisplayEvents = stepObj.params.ondisplayevents || {};
            Object.values(onDisplayEvents).forEach((displayEvent) => {
              let eventElement = onDisplayEvents[displayEvent].ondisplayeventelement;
              const eventsToTrigger = onDisplayEvents[displayEvent].ondisplayevent;
              if (eventElement !== '' && eventsToTrigger.length > 0) {
                eventElement = document.querySelector(eventElement);
                if (eventElement) {
                  eventsToTrigger.forEach((eventName) => {
                    // console.log(`firing event ${eventName}`);
                    const event = new MouseEvent(eventName, {
                      view: window,
                      bubbles: true,
                      cancelable: true,
                    });
                    eventElement.dispatchEvent(event);
                  });
                }
              }
            });
          }, 350);
        }
      },
    },
  });

  if (stepObj.target) {
    step.updateStepOptions({
      attachTo: {
        element: stepObj.target,
        on: stepObj.position,
        url: stepObj.url,
        type: stepObj.type,
        interactive_type: stepObj.interactive_type,
        params: stepObj.params,
      },
    });
  } else {
    step.updateStepOptions({
      attachTo: {
        url: stepObj.url,
        type: stepObj.type,
        interactive_type: stepObj.interactive_type,
        params: stepObj.params,
      },
    });
  }

  if (stepObj.type !== 'next') {
    // Remove stored key to prevent pages to open in the wrong tab
    const storageKey = `${Joomla.getOptions('system.paths').root}/${stepObj.url}`;
    if (sessionStorage.getItem(storageKey)) {
      sessionStorage.removeItem(storageKey);
    }
  }

  step.on(
    'before-show',
    () => {
      const preDisplayEvents = stepObj.params.predisplayevents || {};

      Object.values(preDisplayEvents).forEach((displayEvent) => {
        let eventElement = preDisplayEvents[displayEvent].predisplayeventelement;
        const eventsToTrigger = preDisplayEvents[displayEvent].predisplayevent;
        if (eventElement !== '' && eventsToTrigger.length > 0) {
          eventElement = document.querySelector(eventElement);
          if (eventElement) {
            eventsToTrigger.forEach((eventName) => {
              // console.log(`firing event ${eventName}`);
              const event = new MouseEvent(eventName, {
                view: window,
                bubbles: true,
                cancelable: true,
              });
              eventElement.dispatchEvent(event);
            });
          }
        }
      });

      const gtBeforeStep = new CustomEvent('guided-tour-before-show-step', {
        detail: {
          stepObj,
        },
        bubbles: true,
        tourId: sessionStorage.getItem('tourId'),
      });
      document.dispatchEvent(gtBeforeStep);
    },
  );

  tour.addStep(step);
}

function showTourInfo(tour, stepObj) {
  tour.addStep({
    title: stepObj.title,
    text: stepObj.description,
    classes: 'shepherd-theme-arrows',
    buttons: [
      {
        classes: 'btn btn-primary shepherd-button-primary',
        action() {
          return this.next();
        },
        text: Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_START'),
      },
    ],
    id: 'tourinfo',
    when: {
      show() {
        sessionStorage.setItem('currentStepId', 'tourinfo');
        addProgressIndicator(this.getElement(), 1, sessionStorage.getItem('stepCount'));
      },
    },
  });
}

function pushCompleteButton(buttons) {
  buttons.push({
    text: Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_COMPLETE'),
    classes: 'btn btn-primary shepherd-button-primary',
    action() {
      return this.cancel();
    },
  });
}

function pushNextButton(buttons, step, disabled = false, disabledClass = '') {
  buttons.push({
    text: Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_NEXT'),
    classes: `btn btn-primary shepherd-button-primary step-next-button-${step.id} ${disabledClass}`,
    action() {
      return this.next();
    },
    disabled,
  });
}

function addBackButton(buttons, step) {
  buttons.push({
    text: Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_BACK'),
    classes: 'btn btn-secondary shepherd-button-secondary',
    action() {
      if (step.type === 'redirect') {
        sessionStorage.setItem('currentStepId', step.id - 1);
        const previousStepUrl = sessionStorage.getItem('previousStepUrl');
        if (previousStepUrl) {
          sessionStorage.removeItem('previousStepUrl');
          window.location.href = previousStepUrl;
        }
      }
      return this.back();
    },
  });
}

function startTour(obj) {
  // We store the tour id to restart on site refresh
  sessionStorage.setItem('tourId', obj.id);
  sessionStorage.setItem('stepCount', String(obj.steps.length));

  // Try to continue
  const currentStepId = sessionStorage.getItem('currentStepId');
  let prevStep = null;

  let ind = -1;

  if (currentStepId != null && Number(currentStepId) > -1) {
    ind = typeof obj.steps[currentStepId] !== 'undefined' ? Number(currentStepId) : -1;
    // When we have more than one step, we save the previous step
    if (ind > 0) {
      prevStep = obj.steps[ind - 1];
    }
  }

  // Start tour building
  const tour = getTourInstance();

  // No step found, let's start from the beginning
  if (ind < 0) {
    // First check for redirect
    const uri = Joomla.getOptions('system.paths').rootFull;
    const currentUrl = window.location.href;

    if (currentUrl !== uri + obj.steps[0].url) {
      window.location.href = uri + obj.steps[0].url;

      return;
    }

    // Show info
    showTourInfo(tour, obj.steps[0]);
    ind = 1;
  }

  // Now let's add all followup steps
  const len = obj.steps.length;
  let buttons;

  for (let index = ind; index < len; index += 1) {
    buttons = [];

    // If we have at least done one step, let's allow a back step
    // - if after the start step
    // - if not the first step after a form redirect
    // - if after a simple redirect
    if (prevStep === null || index > ind || obj.steps[index].type === 'redirect') {
      addBackButton(buttons, obj.steps[index]);
    }

    if (
      obj
      && obj.steps[index].target
      && obj.steps[index].type === 'interactive'
    ) {
      if (typeof obj.steps[index].params === 'string' && obj.steps[index].params !== '') {
        obj.steps[index].params = JSON.parse(obj.steps[index].params);
      } else {
        obj.steps[index].params = [];
      }

      const ele = document.querySelector(obj.steps[index].target);
      if (ele) {
        if (obj && obj.steps && obj.steps[index] && obj.steps[index].interactive_type) {
          switch (obj.steps[index].interactive_type) {
            case 'submit':
              ele.addEventListener('click', () => {
                if (!sessionStorage.getItem('tourId')) {
                  return;
                }
                sessionStorage.setItem('currentStepId', obj.steps[index].id + 1);
              });
              break;

            case 'text':
              ele.step_id = index;
              if (
                (ele.hasAttribute('required') || (obj.steps[index].params.required || 0))
                && (
                  (ele.tagName.toLowerCase() === 'input' && ['email', 'password', 'search', 'tel', 'text', 'url'].includes(ele.type))
                || ele.tagName.toLowerCase() === 'textarea'
                )
              ) {
                ['input', 'focus'].forEach((eventName) => ele.addEventListener(eventName, (event) => {
                  if (!sessionStorage.getItem('tourId')) {
                    return;
                  }
                  if ((obj.steps[index].params.requiredvalue || '') !== '') {
                    if (event.target.value.trim() === obj.steps[index].params.requiredvalue) {
                      enableButton(event);
                    } else {
                      disableButton(event);
                    }
                  } else if (event.target.value.trim().length) {
                    enableButton(event);
                  } else {
                    disableButton(event);
                  }
                }));
              }
              break;

            case 'checkbox_radio':
              ele.step_id = index;
              if (
                ele.tagName.toLowerCase() === 'input'
                && (ele.hasAttribute('required') || (obj.steps[index].params.required || 0))
                && ['checkbox', 'radio'].includes(ele.type)
              ) {
                ['click'].forEach((eventName) => ele.addEventListener(eventName, (event) => {
                  if (!sessionStorage.getItem('tourId')) {
                    return;
                  }
                  if (event.target.checked) {
                    enableButton(event);
                  } else {
                    disableButton(event);
                  }
                }));
              }
              break;

            case 'select':
              ele.step_id = index;
              if (
                ele.tagName.toLowerCase() === 'select'
                && (ele.hasAttribute('required') || (obj.steps[index].params.required || 0))
              ) {
                ['change'].forEach((eventName) => ele.addEventListener(eventName, (event) => {
                  if (!sessionStorage.getItem('tourId')) {
                    return;
                  }
                  if ((obj.steps[index].params.requiredvalue || '') !== '') {
                    if (event.target.value.trim() === obj.steps[index].params.requiredvalue) {
                      enableButton(event);
                    } else {
                      disableButton(event);
                    }
                  } else if (event.target.value.trim().length) {
                    enableButton(event);
                  } else {
                    disableButton(event);
                  }
                }));
              }
              break;

            case 'button':
              tour.next();
              break;

            case 'other':
            default:
              break;
          }
        }
      }
    }

    if (index < len - 1) {
      if (
        (obj && obj.steps[index].type !== 'interactive')
        || (obj && ['text', 'checkbox_radio', 'select', 'other'].includes(obj.steps[index].interactive_type))
      ) {
        pushNextButton(buttons, obj.steps[index]);
      }
    } else {
      pushCompleteButton(buttons);
    }

    addStepToTourButton(tour, obj.steps[index], buttons);
    prevStep = obj.steps[index];
  }

  tour.start();
}

function loadTour(tourId) {
  if (tourId > 0) {
    const url = `${Joomla.getOptions('system.paths').rootFull}administrator/index.php?option=com_ajax&plugin=guidedtours&group=system&format=json&id=${tourId}`;
    fetch(url)
      .then((response) => response.json())
      .then((result) => {
        if (!result.success) {
          if (result.messages) {
            Joomla.renderMessages(result.messages);
          }

          // Kill all tours if we can't find it
          emptyStorage();
        }
        startTour(result.data);
      })
      .catch((error) => {
        // Kill the tour if there is a problem with selector validation
        emptyStorage();

        const messages = { error: [Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_TOUR_ERROR')] };
        Joomla.renderMessages(messages);

        throw new Error(error);
      });
  }
}

// Opt-in Start buttons
document.querySelector('body').addEventListener('click', (event) => {
  // Click somewhere else
  if (!event.target || !event.target.classList.contains('button-start-guidedtour')) {
    return;
  }

  // Click button but missing data-id
  if (typeof event.target.getAttribute('data-id') === 'undefined' || event.target.getAttribute('data-id') <= 0) {
    Joomla.renderMessages({ error: [Joomla.Text._('PLG_SYSTEM_GUIDEDTOURS_COULD_NOT_LOAD_THE_TOUR')] });
    return;
  }

  sessionStorage.setItem('tourToken', String(Joomla.getOptions('com_guidedtours.token')));
  loadTour(event.target.getAttribute('data-id'));
});

// Start a given tour
const tourId = sessionStorage.getItem('tourId');

if (tourId > 0 && sessionStorage.getItem('tourToken') === String(Joomla.getOptions('com_guidedtours.token'))) {
  loadTour(tourId);
} else {
  emptyStorage();
}
