<?php

class tramoModel extends Model
{

    public function obtenerTramo()
    {
        return $this->_db->query("select *from tramo inner join propietario on tramo.id_Propietario=propietario.id_Propietario;")->fetchAll();
    }

    public function obtenerPropietario()
    {
        return $this->_db->query("select *from propietario;")->fetchAll();
    }

  
    public function insertarTramo($tramo,$propietario)
    {
       
        $this->_db->prepare('insert into tramo(nombreTramo,id_Propietario)
    values(:nombre,:propietario)')->execute(array(
                    'nombre' => $tramo,
                    'propietario'=> $propietario
                    
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
