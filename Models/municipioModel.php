<?php

class municipioModel extends Model
{

    public function obtenerMunicipio()
    {
        return $this->_db->query("select *from municipio inner join departamento on departamento_id_departamento=id_departamento;")->fetchAll();
    }

    public function obtenerDepartamento()
    {
        return $this->_db->query("select *from departamento;")->fetchAll();
    }

  
    public function insertarMunicipio($departamento,$nombre)
    {
       
        $this->_db->prepare('insert into municipio(nombre_municipio,departamento_id_departamento)
    values(:nombre,:departamento)')->execute(array(
                    'nombre' => $nombre,
                    'departamento'=> $departamento
                    
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
