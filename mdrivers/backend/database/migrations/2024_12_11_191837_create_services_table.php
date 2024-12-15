<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateServicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            $table->String('uid')->index('uid');
            $table->String('codeb')->default('none')->index('codeb');
            $table->String('name')->default('none')->index('name');
            $table->String('status')->default('none')->index('status');
            $table->String('serviceType')->default('none')->index('serviceType');
            $table->String('optionKey')->default('none')->index('optionKey');
            $table->string('uidCreator')->index('uidCreator');

            $table->string('subscriber')->default('none')->index("subscriber");
            $table->longtext('commentData')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('services');
    }
}
