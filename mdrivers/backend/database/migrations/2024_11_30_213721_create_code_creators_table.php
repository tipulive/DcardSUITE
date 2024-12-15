<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateCodeCreatorsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('code_creators', function (Blueprint $table) {
            $table->id();
            $table->String('uid')->index('uid');
            $table->String('onlineStatus')->default('off')->index('onlineStatus');
            $table->string('code_status')->default('temporary')->index('code_status');//or mine
            $table->string('code_name')->default('none')->index('code_name');
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
        Schema::dropIfExists('code_creators');
    }
}








