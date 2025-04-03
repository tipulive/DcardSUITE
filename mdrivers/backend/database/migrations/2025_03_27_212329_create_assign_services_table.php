<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateAssignServicesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('assign_services', function (Blueprint $table) {

            $table->id();

            $table->String('uid')->index('uid');//uid ya services
            $table->String('uidCode')->default('none')->index('uidCode');//* code*

            $table->String('status')->default('none')->index('status');


           // $table->String('optionKey')->default('none')->index('optionKey');
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
        Schema::dropIfExists('assign_services');
    }
}
