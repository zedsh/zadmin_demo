<?php

namespace App\Http\Controllers\Admin;

use App\Http\Requests\Admin\UserRequest;
use App\User;
use Illuminate\Support\Facades\Hash;
use zedsh\zadmin\Fields\HiddenField;
use zedsh\zadmin\Fields\PasswordField;
use zedsh\zadmin\Fields\TextField;
use zedsh\zadmin\Forms\BaseForm;
use zedsh\zadmin\Lists\Columns\ActionsColumn;
use zedsh\zadmin\Lists\Columns\TextColumn;
use zedsh\zadmin\Lists\TableList;

class UserController extends AdminController
{
    public function __construct()
    {
//        $this->middleware('auth');
    }

    public function delete($id)
    {
        User::query()->findOrFail($id)->delete();
        return response()->redirectToRoute('user.list');
    }

    public function save(UserRequest $request)
    {
        if (!empty($request->input('id'))) {
            $model = User::query()->findOrFail($request->input('id'));
        } else {
            $model = new User();
        }

        $model->fill($request->validated());
        if($request->has('password')) {
            $model->password = Hash::make($request->input('password'));
        }
        $model->save();
        return response()->redirectToRoute('user.list');
    }

    public function edit($id)
    {

        $model = User::query()->findOrFail($id);
        $form = new BaseForm('main', [
            (new HiddenField('id'))->setValue($id),
            new TextField('name', 'Имя'),
            new TextField('email', 'Email'),
            new PasswordField('password', 'Пароль'),
            new PasswordField('password_confirmation', 'Подтвердите пароль'),
        ]);
        $form->setModel($model);
        $form->setTitle('Пользователь');
        $form->setBack(route('user.list'));
        $form->setAction(route('user.save', ['id' => $id]));

        return $this->render($form);
    }

    public function add()
    {

        $model = new User();
        $form = new BaseForm('main', [
            new TextField('name', 'Имя'),
            new TextField('email', 'Email'),
            new PasswordField('password', 'Пароль'),
            new PasswordField('password_confirmation', 'Подтвердите пароль'),
        ]);
        $form->setModel($model);
        $form->setTitle('Пользователь');
        $form->setBack(route('user.list'));
        $form->setAction(route('user.save'));

        return $this->render($form);
    }

    public function list()
    {
        $list = new TableList('UserList');
        $list->setTitle('Список пользователей');
        $list->setColumns([
            (new ActionsColumn())->setEditRoute('user.edit')->setDeleteRoute('user.delete')->setDeleteOn()->setEditOn()->setRouteParams(['id']),
            (new TextColumn('id', '#'))->setWidth(50),
            new TextColumn('name', 'Имя'),
            new TextColumn('email', 'Email'),
        ]);
        $list->enableAdd();
        $list->setAddPath(route('user.add'));
        $list->setQuery(User::query());
        $list->enablePaginate();
        $list->setItemsOnPage(10);

        return $this->render($list);
    }
}
