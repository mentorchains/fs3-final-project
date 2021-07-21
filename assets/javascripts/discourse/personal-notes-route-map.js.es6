export default function() {
  this.route("personal-notes", function() {
    this.route("actions", function() {
      this.route("show", { path: "/:id" });
    });
  });
};
