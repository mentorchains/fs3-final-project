import { withPluginApi } from "discourse/lib/plugin-api";
import { iconNode } from "discourse-common/lib/icon-library";
import { h } from "virtual-dom";
let icon = iconNode("sticky-note");

function initializePersonalNotes(api) {
    const siteSettings = api.container.lookup("site-settings:main");
    const currentUser = api.getCurrentUser();
    if (!currentUser) {
        return;
    }
    if (!siteSettings.personal_notes_enabled) {
        return;
    }
    // https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/lib/plugin-api.js.es6
    api.createWidget("note-menu", {
        tagName: "div.note-panel",

        panelContents() {
            return h("div#quick-notes-container", [
                h("h1", "Personal Notes"),
                h("div.notes-search-input", [
                    h("input#notes-search", { type: "text", placeholder: "search notes" }),
                    iconNode("search"),
                ]),
                h("ul", [
                    h("li", h("a", [icon, "Sticky Note 1"])),
                    h("li", h("a", [icon, "Sticky Note 2"])),
                    h("li", h("a", [icon, "Sticky Note 3"])),
                ]),
                h("a", { title: "view all notes", id: "all-notes-icon" }, iconNode("angle-down")),
            ]);
        },

        html() {
            return this.attach("menu-panel", {
                contents: () => this.panelContents(),
            });
        },

        clickOutside() {
            this.sendWidgetAction("toggleNote");
        },
    });

    api.decorateWidget("header-icons:after", function (helper) {
        const headerState = helper.widget.parentWidget.state;
        let contents = [];
        contents.push(
            helper.attach("header-dropdown", {
                title: "take notes",
                icon: "sticky-note",
                active: headerState.noteVisible,
                iconId: "toggle-note-menu",
                action: "toggleNote",
            })
        );
        if (headerState.noteVisible) {
            contents.push(helper.attach("note-menu"));
        }
        return contents;
    });

    api.attachWidgetAction("header", "toggleNote", function () {
        this.state.noteVisible = !this.state.noteVisible;
    });

    api.onPageChange(() => {
        // let colorIds = ['first-color', 'second-color', 'third-color', 'fourth-color', 'fifth-color', 'transparent-choice'];
        let colorIds = [
            "first-color",
            "second-color",
            "third-color",
            "fourth-color",
            "fifth-color",
        ];
        // let colors = ['#fdfd96','pink','paleturquoise','palegreen','lightgrey', 'transparent'];
        let colors = ["#fdfd96", "pink", "paleturquoise", "palegreen", "lightgrey"];
        for (let i = 0; i < colorIds.length; i++) {
            document.getElementById(`${colorIds[i]}`).onclick = function () {
                document.documentElement.style.setProperty("--note-background", `${colors[i]}`);
            };
        }

        document.getElementById("note-button").onclick = function () {
            var elem = document.getElementById("note-body");
            if (elem.style.display == "block") {
                elem.style.display = "none";
            } else {
                elem.style.display = "block";
            }
        };
        document.getElementById("saveStyle").onclick = function () {
            let font = document.getElementById("fonts-selector").value;
            let font_style = document.getElementById("font-styles-selector").value;
            let font_size = document.getElementById("font-sizes-selector").value;

            if (
                font == "font-default" &&
                font_style == "style-default" &&
                font_size == "size-default"
            ) {
                return;
            }

            if (font_style == "italic") {
                document.getElementById("note-textarea").style =
                    "font-family: " +
                    font +
                    ";\n" +
                    "font-style: " +
                    font_style +
                    ";\n" +
                    "font-size: " +
                    font_size +
                    ";";
            } else {
                document.getElementById("note-textarea").style =
                    "font-family: " +
                    font +
                    ";\n" +
                    "font-weight: " +
                    font_style +
                    ";\n" +
                    "font-size: " +
                    font_size +
                    ";";
            }
        };

        document.getElementById("styleSettings").onclick = function () {
            let elem = document.getElementById("note-body-buttons");
            if (elem.style.display == "flex") {
                elem.style.display = "none";
            } else {
                elem.style.display = "flex";
            }
        };
    });
}

export default {
    name: "personal_notes",

    initialize() {
        withPluginApi("0.8.31", (api) => initializePersonalNotes(api));
    },
};
