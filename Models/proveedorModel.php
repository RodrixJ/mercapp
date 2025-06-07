<?php

class proveedorModel extends Model
{

    public function obtenerProveedor()
    {
        return $this->_db->query("select *from proveedor_servicio inner join operarios on operario_id_operario=id_operario inner join servicio on servicio_id_servicio=id_servicio;")->fetchAll();
    }


    public function obtenerOperario()
    {
        return $this->_db->query("select *from operarios;")->fetchAll();
    }

    public function obtenerServicio()
    {
        return $this->_db->query("select *from servicio;")->fetchAll();
    }

    
    public function obtenerCementerio()
    {
        return $this->_db->query("select *from cementerio;")->fetchAll();
    }

    public function insertarOperario($nombre,$telefono,$estado,$especialidad,$direccion,$imagen)
    {
       
        $this->_db->prepare('insert into servicio(tipo_servicio,descripcion,precio,imagen)
    values(:tipo,:descripcion,:precio,:imagen)')->execute(array(
                    'tipo' => $tipo,
                    'descripcion' => $descripcion,
                    'precio' => $precio,
                    'imagen' => $imagen
                    
                ));

    }

    

    public function insertarOperarioSinImagen($tipo,$descripcion,$precio)
    {
       
        $this->_db->prepare('insert into servicio(tipo_servicio,descripcion,precio)
    values(:tipo,:descripcion,:precio)')->execute(array(
                    'tipo' => $tipo,
                    'descripcion' => $descripcion,
                    'precio' => $precio
                    
                ));

    }
  

    





}
