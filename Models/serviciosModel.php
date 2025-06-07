<?php

class serviciosModel extends Model
{

    public function obtenerServicios()
    {
        return $this->_db->query("select *from servicio;")->fetchAll();
    }

  
    public function insertarServicio($tipo,$descripcion,$precio,$imagen)
    {
       
        $this->_db->prepare('insert into servicio(tipo_servicio,descripcion,precio,imagen)
    values(:tipo,:descripcion,:precio,:imagen)')->execute(array(
                    'tipo' => $tipo,
                    'descripcion' => $descripcion,
                    'precio' => $precio,
                    'imagen' => $imagen
                    
                ));

    }

    

    public function insertarServicioSinImagen($tipo,$descripcion,$precio)
    {
       
        $this->_db->prepare('insert into servicio(tipo_servicio,descripcion,precio)
    values(:tipo,:descripcion,:precio)')->execute(array(
                    'tipo' => $tipo,
                    'descripcion' => $descripcion,
                    'precio' => $precio
                    
                ));

    }

    public function actualizarServicio($id, $nombre)
    {
        $sql = 'UPDATE servicio 
        SET nombre_departamento = :nombre
        WHERE id_departamento = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombre,
            'id' => $id
            
        ));

    }

    public function borrarServicio($id)
    {
        $this->_db->prepare('delete from servicio where id_departamento=:idDepartamento')->execute(array('idDepartamento' => $id));
    }




}
