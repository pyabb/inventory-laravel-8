<template>
	<div class="col-md-12">
		<div class="modal fade" id="update-category" tabindex="-1" role="dialog">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="defaultModalLabel">Actualizar rol</h4>
					</div>
					<div class="modal-body">
						<div class="alert alert-danger" v-if="errors">
							<ul>
								<li v-for="error in errors">{{ error[0] }}</li>
							</ul>
						</div>
						<form>
							<div class="row">
								<div class="col-md-12">
									<div class="input-group">
										<span class="input-group-addon">
											<i class="material-icons">admin_panel_settings</i>
										</span>
										<div class="form-line">
											<input type="text" class="form-control date" placeholder="Nombre" v-model="role.role_name">
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<br>
						<button @click="updateRole(role.id)" type="button" class="btn btn-success waves-effect">Actualizar</button>
						<button @click="closeModal()" type="button" class="btn btn-default waves-effect"
							data-dismiss="modal">Cancelar</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
import { EventBus } from '../../event-bus';
import mixin from '../../mixin';
import axios from '../../axios-config';

export default {
	name: 'update-role',
	mixins: [mixin],
	data() {
		return {
			role: {
				id: 0,
				role_name: '',
			},
			errors: null
		}
	},
	created() {
		let vm = this;

		EventBus.on('role-edit', function (id) {
			vm.role.id = id;
			vm.editRole(id);
			$('#update-category').modal('show');
		});

		$('#update-category').on('hidden.bs.modal', function () {
			vm.closeModal();
		});
	},
	methods: {
		editRole(id) {
			axios.get(base_url + 'role/' + id + '/edit')
				.then(response => {
					this.role = {
						id: response.data.id,
						role_name: response.data.role_name,
					}
				})
		},
		updateRole(id) {
			axios.post(base_url + 'role/update/' + id, this.role)
				.then(res => {
					if (res.data.status === 'success') {
						this.successAlert(res.data);
						EventBus.emit('role-created', 1);
						this.closeModal();
						$('#update-category').modal('hide');
					}
				})
				.catch(err => {
					if (err.response) {
						this.errors = err.response.data.errors;
					}
				})
		},
		closeModal() {
			this.errors = null;
			this.role = { 'id': 0, 'role_name': '' };
			EventBus.emit('role-created', 1);
		}
	}
}
</script>
