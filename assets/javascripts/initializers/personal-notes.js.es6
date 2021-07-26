import { withPluginApi } from "discourse/lib/plugin-api";
import { iconNode } from "discourse-common/lib/icon-library";
let icon = iconNode('sticky-note');

function initializePersonalNote(api) {
  // https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/lib/plugin-api.js.es6
  api.decorateWidget('header-icons:before', helper => {
    // note-dropdown 
    return helper.h('li.header-dropdown-toggle', [
      helper.h('a.icon.btn-flat#note-dropdown', {
        title: 'take notes',
      }, icon),
    ]);
  });
  
  api.onPageChange(() => {
    let colorIds = ['first-color', 'second-color', 'third-color', 'fourth-color', 
                   'fifth-color', 'sixth-color', 'seventh-color', 'eighth-color', 'ninth-color'];
    let colors = ['white', 'blanchedalmond', '#fdfd96', 'pink', 'orange', 'paleturquoise', 'palegreen', 'plum', 'lightgrey'];
    for (let i = 0; i < colorIds.length; i++) {
      document.getElementById(`${colorIds[i]}`).onclick = function() {
        document.documentElement.style.setProperty("--note-background", `${colors[i]}`);
      }
    }
    
    document.getElementById('note-button').onclick = function() {
      var elem = document.getElementById("note-body");
      if (elem.style.display == "block") {
        elem.style.display = "none";
      } else {
        elem.style.display = "block";
      }
    }

    document.getElementById('note-dropdown').onclick = function() {
      var elem = document.getElementById("quick-notes-container");
      if (elem.style.display == "block") {
        elem.style.display = "none";
      } else {
        elem.style.display = "block";
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
