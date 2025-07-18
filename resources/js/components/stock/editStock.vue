<template>
    <div class="wrap">
        <div class="modal fade" id="edit-stock" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="defaultModalLabel">Actualizar inventario</h4>
                    </div>
                    <div class="modal-body">
                        <div class="alert alert-danger" v-if="errors">
                            <ul>
                                <li v-for="error in errors">{{ error[0] }}</li>
                            </ul>
                        </div>
                        <form>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">palette</i>
                                        </span>
                                        <div class="form-line">
                                            <select class="form-control select2"
                                                    id="editFindProductSelect"
                                            >
                                                <option value>Selecciona una categoría</option>
                                                <option v-for="(value, index) in categorys"
                                                        :value="value.id"
                                                >
                                                    {{ value.name }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">shopping_bag</i>
                                        </span>
                                        <div class="form-line">
                                            <select class="form-control select2"
                                                    id="editChooseProductSelect"
                                            >
                                                <option value>Selecciona un producto</option>
                                                <option v-for="(value, index) in products" :value="value.id">
                                                    {{ value.product_name }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">supervisor_account</i>
                                        </span>
                                        <div class="form-line">
                                            <select class="form-control select2"
                                                    id="editChooseProviderSelect"
                                                    data-live-serach="true"
                                            >
                                                <option value>Selecciona un proveedor</option>
                                                <option v-for="(vd, index) in vendors"
                                                        :value="vd.id"
                                                >
                                                    {{ vd.name }}
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">playlist_add_check</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control"
                                                   placeholder="Comprobante Nº:"
                                                   title="Comprobante Nº:"
                                                   v-model="stock.chalan_no"
                                                   disabled
                                            />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">attach_money</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control" placeholder="Precio de compra"
                                                   v-model="stock.buying_price"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">attach_money</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control" placeholder="Precio de venta"
                                                   v-model="stock.selling_price"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">add</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control" placeholder="Cantidad "
                                                   v-model="stock.current_quantity"
                                                   disabled/>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-group">
                                        <span class="input-group-addon">
                                          <i class="material-icons">assignment</i>
                                        </span>
                                        <div class="form-line">
                                            <input type="text" class="form-control" placeholder="Nota" title="Nota"
                                                   v-model="stock.note"/>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <br/>
                        <button @click="updateStock(stock.id)" type="button" class="btn btn-success waves-effect">
                            Actualizar
                        </button>
                        <button @click="resetForm()" type="button" class="btn btn-default waves-effect"
                                data-dismiss="modal">Cerrar
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
import { EventBus } from "../../event-bus";
import mixin from "../../mixin.js";
import axios from "../../axios-config.js";
import { nextTick } from "vue";

export default {
    props: ["vendors", "categorys"],
    mixins: [mixin],
    data() {
        return {
            stock: {
                id: "",
                product: "",
                category: "",
                vendor: "",
                quantity: "",
                current_quantity: "",
                buying_price: "",
                selling_price: "",
                note: "",
                chalan_no: "",
            },
            products: [],
            errors: null,
        };
    },
    created() {
        const vm = this;

        EventBus.on("edit-stock", async (id) => {
            try {
                const stockResponse = await axios.get(base_url + "stock/" + id + "/edit");
                const stockData = stockResponse.data;

                const productsResponse = await axios.get(base_url + "category/product/" + stockData.category_id);
                
                vm.products = productsResponse.data;
                vm.stock = {
                    id: stockData.id,
                    product: stockData.product_id,
                    category: stockData.category_id,
                    vendor: stockData.vendor_id,
                    quantity: stockData.stock_quantity,
                    current_quantity: stockData.current_quantity,
                    buying_price: stockData.buying_price,
                    selling_price: stockData.selling_price,
                    note: stockData.note,
                    chalan_no: stockData.chalan_no,
                };
                
                await nextTick();

                $('#editFindProductSelect').val(vm.stock.category).trigger('change');
                $('#editChooseProviderSelect').val(vm.stock.vendor).trigger('change');
                $('#editChooseProductSelect').val(vm.stock.product).trigger('change');
                $("#edit-stock").modal("show");

            } catch (error) {
                console.error("Error al cargar datos para la edición:", error);
            }
        });

        $("#edit-stock").on("hidden.bs.modal", function () {
            vm.resetForm();
        });
    },
    mounted() {
        const vm = this;

        $('#editFindProductSelect').on('change', function () {
            const categoryId = parseInt($(this).val());
            if (vm.stock.category !== categoryId) {
                vm.stock.category = categoryId;
                vm.stock.product = '';
                vm.findProduct();
            }
        });
        
         $('#editChooseProductSelect').on('change', function () {
            vm.stock.product = parseInt($(this).val());
        });
        
         $('#editChooseProviderSelect').on('change', function () {
            vm.stock.vendor = parseInt($(this).val());
        });
    },
    methods: {
        findProduct() {
            if (!this.stock.category) {
                this.products = [];
                nextTick(() => {
                    $('#editChooseProductSelect').val(null).trigger('change');
                });
                return;
            }

            axios
                .get(base_url + "category/product/" + this.stock.category)
                .then((response) => {
                    this.products = response.data;
                    nextTick(() => {
                        $('#editChooseProductSelect').val(null).trigger('change');
                    });
                })
                .catch(error => {
                    console.error("Error al buscar productos:", error);
                    this.products = [];
                    nextTick(() => {
                        $('#editChooseProductSelect').val(null).trigger('change');
                    });
                });

        },
        updateStock(id) {
            axios
                .post(base_url + "stock/update/" + id, this.stock)
                .then((response) => {
                    $("#edit-stock").modal("hide");
                    this.errors = null;
                    EventBus.emit("stock-created", response.data);
                    this.successAlert(response.data);
                })
                .catch((err) => {
                    if (err.response) {
                        this.errors = err.response.data.errors;
                    }
                });
        },
        resetForm() {
            this.stock = {
                id: "",
                product: "",
                category: "",
                vendor: "",
                quantity: "",
                current_quantity: "",
                buying_price: "",
                selling_price: "",
                note: "",
                chalan_no: ""
            };
            this.products = [];
            this.errors = null;
            nextTick(() => {
                 $('#editFindProductSelect').val(null).trigger('change');
                 $('#editChooseProviderSelect').val(null).trigger('change');
                 $('#editChooseProductSelect').val(null).trigger('change');
            });
        },
    },
};
</script>
