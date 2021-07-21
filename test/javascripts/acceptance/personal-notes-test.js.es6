import { acceptance } from "discourse/tests/helpers/qunit-helpers";

acceptance("PersonalNotes", { loggedIn: true });

test("PersonalNotes works", async assert => {
  await visit("/admin/plugins/personal-notes");

  assert.ok(false, "it shows the PersonalNotes button");
});
