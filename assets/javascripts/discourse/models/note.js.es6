import RestModel from "discourse/models/rest";

export default RestModel.extend({
    updateProperties() {
        return this.getProperties("content");
    },
});
