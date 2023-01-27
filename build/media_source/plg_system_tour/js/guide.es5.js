/**
 * @copyright   (C) 2022 Open Source Matters, Inc. <https://www.joomla.org>
 * @license     GNU General Public License version 2 or later; see LICENSE.txt
 */

function checkAndRedirect(redirectUrl) {
  var currentURL = window.location.href;
  if (currentURL != redirectUrl) {
    window.location.href = redirectUrl;
  }
}
function createTour() {
  return new Shepherd.Tour({
    defaultStepOptions: {
      scrollTo: true,
      classes: "shadow",
      cancelIcon: {
        enabled: true,
      },
      classes: "class-1 class-2 shepherd-theme-arrows",
      scrollTo: { behavior: "smooth", block: "center" },
    },
    useModalOverlay: true,
    keyboardNavigation: true,
  });
}
function addCancelTourButton(tour) {
  tour.on("cancel", () => {
    sessionStorage.clear();
  });
}
function addStepToTourButton(tour, obj, index, buttons, uri) {
  tour.addStep({
    title: obj.steps[index].title,
    text: obj.steps[index].description,
    classes: "intro-step shepherd-theme-arrows",
    attachTo: {
      element: obj.steps[index].target,
      on: obj.steps[index].position,
      url: obj.steps[index].url,
      type: obj.steps[index].type,
      interactive_type: obj.steps[index].interactive_type,
    },

    buttons: buttons,
    id: obj.steps[index].id,
    arrow: true,
    showOn: obj.steps[index].position,
    when: {
      show() {
        var currentstepIndex = `${tour.currentStep.id}` - "0";
        sessionStorage.setItem("currentStepId", currentstepIndex);
        if (obj.steps[index].type == 1) {
          checkAndRedirect(uri + tour.currentStep.options.attachTo.url);
        }
      },
    },
  });
}
function addInitialStepToTourButton(tour, obj) {
  tour.addStep({
    title: obj.title,
    text: obj.description,
    classes: "intro-step shepherd-theme-arrows",
    attachTo: {
      on: "bottom",
    },
    buttons: [
      {
        action() {
          return tour.next();
        },
        text: "Start",
      },
    ],
    id: obj.id,
  });
}
function pushCompleteButton(buttons, tour) {
  buttons.push({
    text: "Complete",
    classes: "shepherd-button-primary",
    action: function () {
      return tour.cancel();
    },
  });
}
function pushNextButton(buttons, tour, step_id, disabled = false) {
  buttons.push({
    text: "Next",
    classes: `shepherd-button-primary step-next-button-${step_id}`,
    action: function () {
      return tour.next();
    },
    disabled: disabled,
  });
}
function enableButton(e) {
  const ele = document.querySelector(
    `.step-next-button-${e.currentTarget.step_id}`
  );
  ele.removeAttribute("disabled");
}
function pushBackButton(buttons, tour, prev_step) {
  buttons.push({
    text: "Back",
    classes: "shepherd-button-secondary",
    action: function () {
      if (prev_step) {
        const paths = Joomla.getOptions("system.paths");
        sessionStorage.setItem("currentStepId", prev_step.id);
        if (prev_step.type == 1) {
          checkAndRedirect(paths.rootFull + prev_step.url);
        }
      }
      return tour.back();
    },
  });
}

function startTour(obj) {

  const paths = Joomla.getOptions("system.paths");
  const uri = paths.rootFull;

  var currentStepId = sessionStorage.getItem("currentStepId");
  let prev_step = "";
  const tour = createTour();
  var ind = 0;
  if (currentStepId) {
    ind = obj.steps.findIndex((x) => x.id == currentStepId);
    if (ind > 0) {
      prev_step = obj.steps[ind - 1];
    }
  } else {
    ind = 0;
    addInitialStepToTourButton(tour, obj);
  }
  for (index = ind; index < obj.steps.length; index++) {
    let buttons = [];
    var len = obj.steps.length;

    pushBackButton(buttons, tour, prev_step);

    if (
      obj &&
      obj.steps[index].target &&
      obj.steps[index].type == 2
    ) {
      const ele = document.querySelector(obj.steps[index].target);
      if (ele) {
        if (obj && obj.steps[index].interactive_type === 2) {
          ele.step_id = index;
          ele.addEventListener("input", enableButton, enableButton);
        }
        if (obj && obj.steps[index].interactive_type === 1) {
          ele.addEventListener("click", tour.next, tour.next);
        }
      }
    }

    if (index != len - 1) {
      let disabled = false;
      if (obj && obj.steps[index].interactive_type == 2)
        disabled = true;
      if (
        (obj && obj.steps[index].type !== 2) ||
        (obj && obj.steps[index].interactive_type == 2) ||
        (obj && obj.steps[index].interactive_type == 3)
      )
        pushNextButton(buttons, tour, index, disabled);
    } else {
      pushCompleteButton(buttons, tour);
    }

    addStepToTourButton(tour, obj, index, buttons, uri);
    prev_step = obj.steps[index];
  }
  tour.start();
  addCancelTourButton(tour);
}

Joomla = window.Joomla || {};
(function (Joomla, window) {
  document.addEventListener("GuidedTourLoaded", function (e) {

    sessionStorage.setItem("tourId", e.detail.id);

    const paths = Joomla.getOptions("system.paths");
    const uri = paths.rootFull;

    var currentURL = window.location.href;
    if (currentURL != uri + e.detail.url) {
      window.location.href = uri + e.detail.url;
    } else {
      startTour(e.detail);
    }
  });

  document.addEventListener("DOMContentLoaded", function (e) {

    tourId = sessionStorage.getItem("tourId");

    if (tourId) {
      let myTour = Joomla.getOptions("myTour");
      let obj = JSON.parse(myTour);

      startTour(obj);
    }
  });
})(Joomla, window);
