<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTicketwritingsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ticketwritings', function (Blueprint $table) {
            $table->id();
            $table->string('uid')->index();
            $table->string('userId')->nullable();
            $table->string('plaqueId')->index();
            $table->string('faultId')->index();
            $table->string('faultTitle')->index();
            $table->longtext('faultDescr')->nullable();
            $table->string('faultPrice')->nullable();
            $table->string('status')->index()->nullable();
            $table->string('statusLive')->index();
            $table->longtext('commentData')->nullable();
            $table->string('uidCreator')->index('uidCreator');
            $table->string('subscriber')->default('none')->index("subscriber");
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
        Schema::dropIfExists('ticketwritings');
    }
}
