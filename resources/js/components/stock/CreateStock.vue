<template>
    <div class="wrap">
        <div class="modal fade" id="create-stock" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="defaultModalLabel">Agregar al inventario</h4>
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
                                                    id="findProductSelect"
                                            >
                                                <option value>Selecciona una categoría</option>
                                                <option v-for="(value, index) in categorys" :value="value.id">
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
                                                    id="chooseProductSelect"
                                            >
                                                <option value="">Selecciona un producto</option>
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
                                                    id="chooseProviderSelect"
                                            >
                                                <option value>Selecciona un proveedor</option>
                                                <option v-for="(vd, index) in vendors" :value="vd.id">{{
                                                        vd.name
                                                    }}
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
                                            <input type="text"
                                                   class="form-control"
                                                   placeholder="Comprobante Nº:"
                                                   title="Comprobante Nº:"
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
                                            <input type="number" class="form-control" placeholder="Cantidad"
                                                   v-model="stock.quantity"/>
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
                        <button @click="createStock()" type="button" class="btn btn-success waves-effect">Agregar
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

export default {
    props: ["vendors", "date", "categorys"],
    mixins: [mixin],
    data() {
        return {
            stock: {
                product: "",
                category: "",
                vendor: "",
                quantity: "",
                buying_price: "",
                selling_price: "",
                note: "",
            },
            products: [],
            errors: null,
        };
    },
    mounted() {
        const vm = this;

        const findProductSelect = $('#findProductSelect');
        findProductSelect.on('change', function () {
            vm.stock.category = parseInt(findProductSelect.val());
            vm.findProduct();
        });

        const chooseProductSelect = $('#chooseProductSelect');
        chooseProductSelect.on('change', function () {
            vm.stock.product = parseInt(chooseProductSelect.val());
        });

        const chooseProviderSelect = $('#chooseProviderSelect');
        chooseProviderSelect.on('change', function () {
            vm.stock.vendor = parseInt(chooseProviderSelect.val());
        });
    },
    methods: {
        findProduct() {
            if (this.stock.category === "") {
                this.products = [];
            } else {
                this.products = [];
                axios
                    .get(base_url + "category/product/" + this.stock.category)
                    .then((response) => {
                        this.products = response.data;
                    });
            }
        },
        createStock() {
            axios
                .post(base_url + "stock", this.stock)
                .then((response) => {
                    $("#create-stock").modal("hide");
                    this.resetForm();
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

        // defaultValue(){

        //           if(this.stock.chalan_no.length <= 20 ){

        //              this.stock.chalan_no = 'Comprobante No:'+this.date;
        //           }

        // },

        resetForm() {
            this.stock = {
                product: "",
                vendor: "",
                quantity: "",
                buying_price: "",
                selling_price: "",
                note: "",
                category: "",
            };
        },
    },
    created() {},
};
</script>
