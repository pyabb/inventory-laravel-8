<?php

namespace Database\Seeders;

use App\Company;
use App\Menu;
use App\Permission;
use App\Role;
use App\User;
use Database\Data\Menu as MenuData;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class ProductionSeeder extends Seeder
{
    /**
     * Run the database seeds for production environment.
     */
    public function run(): void
    {
        // Create a default company
        Company::create([
            'name' => 'Inventory',
            'phone' => '0000000000',
            'address' => 'Inventory Address',
        ]);

        // Create a superadmin role for development (no factory class)
        $role=  Role::create([
            'role_name' => 'Superadministrador',
        ]);

        // Create a super admin user (no factory class)
        $admin = User::create([
            'name' => 'John Doe',
            'email' => 'admin@inventory.org',
            'password' => Hash::make('123123'),
            'role_id' => $role->id,
        ]);

        $menuData = MenuData::list();
        foreach ($menuData as $menu)
        {
            $menuItem = Menu::create([
                'parent_id' => $menu['parent_id'],
                'name' => $menu['name'],
                'icon' => $menu['icon'],
                'menu_url' => $menu['menu_url'],
                'status' => $menu['status'],
            ]);

            Permission::create([
                'role_id' => $admin->role_id,
                'menu_id' => $menuItem->id,
            ]);
        }
    }
}
