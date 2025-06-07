<?php

class indexModel extends Model
{

    public function numeroProductos()
    {
        return $this->_db->query("select *from producto;")->rowCount();
    }

    public function numeroPropietarios()
    {
        return $this->_db->query("select *from propietario;")->rowCount();
    }

     public function obtenerProductos()
    {
        return $this->_db->query("select *from producto inner join tramo on tramo.id_Tramo=producto.id_Tramo;")->fetchAll();
    }

 

 

    

}
