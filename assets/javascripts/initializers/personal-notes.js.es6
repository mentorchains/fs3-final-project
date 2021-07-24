import { withPluginApi } from "discourse/lib/plugin-api";
import { iconNode } from "discourse-common/lib/icon-library";
let icon = iconNode('sticky-note');

function initializePersonalNote(api) {
  // https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/lib/plugin-api.js.es6
  api.decorateWidget('header-icons:before', helper => {
    // note-dropdown 
    return helper.h('li.header-dropdown-toggle.note-dropdown', [
      helper.h('a.icon.btn-flat', {
        title: 'take notes',
      }, icon),
    ]);
  });
  api.onPageChange(() => {
    document.getElementById('note-button').onclick = function() {
      var elem = document.getElementById("note-body");
      if (elem.style.display == "none") {
        elem.style.display = "block";
      } else {
        elem.style.display = "none";
      }
    }
  });
}

export default {
  name: "personal-notes",

  initialize() {
    withPluginApi("0.8.31", initializePersonalNote);
  }
};
