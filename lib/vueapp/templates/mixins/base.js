const ItemableMixin = {
    props: {
        item: {
            type: Object,
            default: function() {
                return {};
            }
        }
    }
};