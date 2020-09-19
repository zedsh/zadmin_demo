Как поднять
=========================
```
cd docker
./up.sh
./dctl.sh run composer install
ln -s ./docker/.env ../.env
./dctl.sh run php artisan migrate
./dctl.sh run php artisan db:seed
```

Заходить на http://localhost/