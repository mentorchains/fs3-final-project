export default Ember.Component.extend({
    init() {
        this._super();
        this.set("notes", []);
        this.fetchNotes();
    },

    fetchNotes() {
        this.store
            .findAll("note")
            .then((result) => {
                for (const note of result.content) {
                    this.notes.pushObject(note);
                }
            })
            .catch(console.error);
    },

    actions: {
        createNote(content) {
            if (!content) {
                return;
            }
            const noteRecord = this.store.createRecord("note", {
                id: Date.now(),
                content: content,
            });

            noteRecord
                .save()
                .then((result) => {
                    console.log(result);
                    this.notes.pushObject(result.target);
                })
                .catch(console.error);
            document.getElementById("note-textarea").value = "";
        },
        // DeleteNote
        deleteNote(note) {
            this.store
                .destroyRecord("note", note)
                .then(() => {
                    console.log(this.notes);
                    this.notes.removeObject(note);
                })
                .catch(console.error);
        },
        // updateNote
        updateNote(id, content) {
            this.store 
                .findRecord('note', id)
                .then((post) => {
                    post.content = content;
                    post.save();
                })
                .catch(console.error);
        },
    },
});
