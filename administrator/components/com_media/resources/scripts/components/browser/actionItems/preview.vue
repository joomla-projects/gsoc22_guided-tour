<template>
  <button
    type="button"
    class="action-preview"
    :aria-label="translate('COM_MEDIA_ACTION_PREVIEW')"
    :title="translate('COM_MEDIA_ACTION_PREVIEW')"
    @keyup.enter="openPreview()"
    @keyup.space="openPreview()"
    @focus="focused(true)"
    @blur="focused(false)"
    @keyup.esc="hideActions()"
  >
    <span
      class="image-browser-action icon-search-plus"
      aria-hidden="true"
      @click.stop="openPreview()"
    />
  </button>
</template>

<script>
export default {
  name: 'MediaBrowserActionItemPreview',
  props: {
    onFocused: { type: Function, default: () => {} },
    mainAction: { type: Function, default: () => {} },
    closingAction: { type: Function, default: () => {} },
  },
  methods: {
    openPreview() {
      this.mainAction();
    },
    hideActions() {
      this.closingAction();
    },
    focused(bool) {
      this.onFocused(bool);
    },
  },
};
</script>
