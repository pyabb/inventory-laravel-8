<template>
	<div class="row">
		<div class="col-md-4">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2" name="type" required="" v-model="report_type" v-select="report_type">
						<option :value="''">Chose Report Type *</option>
						<option :value="'stock'">Stock Report</option>
						<option :value="'sell'">Sell Report</option>
						<option :value="'profit'">Profit Report</option>
						<option :value="'due'">Due Report</option>
						<option :value="'invoice'">Invoice Report</option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="input-group">
				<div class="form-line">
					<Datepicker :required="true"
                                :placeholder="'Date To *'"
                                :name="'start_date'"
						        :class="'form-control'"
                                v-model="start_date"
                    ></Datepicker>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="input-group">
				<div class="form-line">
					<Datepicker :required="true"
                                :placeholder="'Date From *'"
                                :name="'end_date'"
						        :class="'form-control'"
                                v-model="end_date"
                    ></Datepicker>
				</div>
			</div>
		</div>
		<div class="col-md-4" v-if="!isEnable">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2"
                            name="category_id"
                            v-model="category_id"
                            id="categorySelect"
                    >
						<option value="">Chose Category (optional)</option>
						<option v-for="value in category" :value="value.id">
                            {{ value.name }}
                        </option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-4" v-if="!isEnable">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2"
                            name="product_id"
                            v-model="product_id"
                            id="productSelect"
                    >
						<option value="">Chose Product (optional)</option>
						<option v-for="pr in product" :value="pr.id">
                            {{ pr.product_name }}
                        </option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-4" v-if="!isEnable">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2" name="stock_id" v-model="chalan_id" v-select="chalan_id">
						<option value="">Chose Comprobante (optional)</option>
						<option v-for="ch in chalan" :value="ch.id">{{ ch.chalan_no }}</option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-4" v-if="!isEnable">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2" name="vendor_id">
						<option value="">Chose Vendor (optional)</option>
						<option v-for="vn in vendor" :value="vn.id">{{ vn.name }}</option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2" name="customer_id">
						<option value="">Customer (optional)</option>
						<option v-for="cs in customer" :value="cs.id">
                            {{ cs.customer_name }}
                        </option>
					</select>
				</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="input-group">
				<div class="form-line">
					<select class="form-control select2" name="user_id">
						<option value="">Chose Stock Entire / Seller (optional)</option>
						<option v-for="us in user" :value="us.id">
                            {{ us.name }}
                        </option>
					</select>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import Datepicker from 'vue3-datepicker';
import mixin from '../../mixin.js';
import axios from '../../axios-config';

export default {
	props: ['category', 'user', 'customer', 'vendor'],
	components: {
		Datepicker,
	},
	mixins: [mixin],
	data() {
		return {
			report_type: '',
			category_id: '',
			product_id: '',
			chalan_id: '',
			product: [],
			chalan: [],
            start_date: null,
            end_date: null,
		}
	},
    mounted() {
        const vm = this;

        $('#categorySelect').on('change', function() {
            vm.category_id = $(this).val();
            vm.findProduct();
        });

        $('#productSelect').on('change', function() {
            vm.product_id = $(this).val();
            vm.findStock();
        });
    },
	methods: {
		findProduct() {
            console.log(':D');
			this.product = [];
			axios.get(base_url + 'category/product/' + this.category_id)
				.then(response => {
					this.product = response.data;
				})
		},
		findStock() {
			this.chalan = [];
			axios.get(base_url + 'chalan-list/chalan/' + this.product_id)
				.then(response => {
					this.chalan = response.data;
				})
		},
	},
	computed: {
		isEnable() {
			return this.report_type === 'invoice' || this.report_type === 'due';
		}
	}
}
</script>
