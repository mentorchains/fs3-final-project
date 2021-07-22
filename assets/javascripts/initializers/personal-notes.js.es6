import { withPluginApi } from "discourse/lib/plugin-api";
import { iconNode } from "discourse-common/lib/icon-library";

function initializePersonalNote(api) {
  // https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/lib/plugin-api.js.es6
  api.decorateWidget('header-icons:before', helper => {
    // note-dropdown 
    return helper.h('li.header-dropdown-toggle.note-dropdown', [
      helper.h('a.icon.btn-flat', {
        //href: '',
        title: 'take notes'
      }, iconNode('sticky-note')),
    ]);
  });

  api.decorateWidget('timeline-controls:after', helper => {
    // note-button 
    return helper.h('button.widget-button.btn.btn-default.no-text.btn-icon.note-button', {
        title: 'take notes'
      }, iconNode('sticky-note'),
    );
  });
  
  api.decorateWidget('timeline-footer-controls:after', helper => {
    // note-button 
    return helper.h('button.widget-button.btn.btn-default.no-text.btn-icon.note-button', {
      title: 'take notes'
    }, iconNode('sticky-note'),
  );
  });
}

export default {
  name: "personal-notes",

  initialize() {
    withPluginApi("0.8.31", initializePersonalNote);
  }
};
