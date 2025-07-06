import Swal from 'sweetalert2';

export default {
    created() {},
    methods: {
        successAlert(data) {
            // console.log(data);
            Swal.fire({
                position: 'top-end',
                icon: data.status,
                title: data.message,
                showConfirmButton: false,
                timer: 1500
            })
        },
    },
    mounted() {
        $('.select2').select2();
        // $('.multiselect__input').addClass('form-control');
    },
    directives: {
        select: {
            twoWay: true,
            bind: function (el, binding, vnode) {
                $(el).select2().on("select2:select", (e) => {
                    // v-model looks for
                    //  - an event named "change"
                    //  - a value with property path "$event.target.value"
                    el.dispatchEvent(new Event('change', { target: e.target }));
                });
            }
        }
    },
    watch: {
        value: function (value) {
            // update value
            $(this.$el).val(value)
        },
        options: function (options) {
            // update options
            $(this.$el).select2({data: options})
        }
    },
    destroyed: function () {
        $(this.$el).off().select2('destroy')
    }
}
