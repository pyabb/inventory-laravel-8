<?php

namespace Database\Data;

class Menu
{
    public static function list(): array
    {
        return [
            ['parent_id' => 0, 'name' => 'Clientes', 'icon' => 'contacts', 'menu_url' => 'customer.index', 'status' => 0],
            ['parent_id' => 0, 'name' => 'Gestión de Productos', 'icon' => 'category', 'menu_url' => NULL, 'status' => 0],
            ['parent_id' => 0, 'name' => 'Gestión de Existencias', 'icon' => 'assignment', 'menu_url' => NULL, 'status' => 0],
            ['parent_id' => 0, 'name' => 'Gestión de usuarios', 'icon' => 'supervised_user_circle', 'menu_url' => NULL, 'status' => 0],
            ['parent_id' => 0, 'name' => 'Reportes', 'icon' => 'receipt_long', 'menu_url' => 'report.index', 'status' => 0],
            ['parent_id' => 0, 'name' => 'Configuración', 'icon' => 'settings', 'menu_url' => NULL, 'status' => 0],
            ['parent_id' => 2, 'name' => 'Categorias', 'icon' => NULL, 'menu_url' => 'category.index', 'status' => 0],
            ['parent_id' => 2, 'name' => 'Productos', 'icon' => NULL, 'menu_url' => 'product.index', 'status' => 0],
            ['parent_id' => 2, 'name' => 'Proveedores', 'icon' => NULL, 'menu_url' => 'supplier.index', 'status' => 0],
            ['parent_id' => 3, 'name' => 'Entradas', 'icon' => NULL, 'menu_url' => 'stock.index', 'status' => 0],
            ['parent_id' => 3, 'name' => 'Salidas / Facturación', 'icon' => NULL, 'menu_url' => 'invoice.index', 'status' => 0],
            ['parent_id' => 4, 'name' => 'Gestión de roles', 'icon' => NULL, 'menu_url' => 'role.index', 'status' => 0],
            ['parent_id' => 4, 'name' => 'Usuarios', 'icon' => NULL, 'menu_url' => 'user.index', 'status' => 0],
            ['parent_id' => 6, 'name' => 'Información de la empresa', 'icon' => NULL, 'menu_url' => 'company.index', 'status' => 0],
            ['parent_id' => 6, 'name' => 'Cambiar la contraseña', 'icon' => NULL, 'menu_url' => 'password.index', 'status' => 0],
        ];
    }
}
