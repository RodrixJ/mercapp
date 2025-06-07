<?php

class propietarioModel extends Model
{

    public function obtenerPropietario()
    {
        return $this->_db->query("select *from propietario;")->fetchAll();
    }

    
  
    public function insertarPropietario($nombre)
    {
       
        $this->_db->prepare('insert into propietario(nombre)
    values(:nombre)')->execute(array(
                    'nombre' => $nombre
                ));

    }

    public function actualizarMunicipio($id,$departamento, $nombre)
    {
        $sql = 'UPDATE municipio 
        SET nombre_municipio = :nombre,
        departamento_id_departamento = :departamento
        WHERE id_municipio = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombre,
            'departamento' => $departamento,
            'id'=> $id
            
        ));

    }

    public function borrarMunicipio($id)
    {
        $this->_db->prepare('delete from municipio where id_municipio=:id')->execute(array('id' => $id));
    }




}
