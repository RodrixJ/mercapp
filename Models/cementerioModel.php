<?php

class cementerioModel extends Model
{

    public function obtenerCementerio()
    {
        return $this->_db->query("select departamento_id_departamento,nombre_municipio,id_cementerio,nombre,latitud,longitud,capacidad,tipo,hora_apertura,
        hora_cierre,municipio_id_municipio from cementerio inner join municipio on 
        id_municipio=municipio_id_municipio;")->fetchAll();
    }

    public function obtenerDepartamento()
    {
        return $this->_db->query("select * from departamento;")->fetchAll();
    }

    public function obtenerMunicipio($idDepartamento)
    {
        return $this->_db->query("select * from municipio where departamento_id_departamento='$idDepartamento'")->fetchAll();
    }

    public function insertarCementerio($nombre, $municipio, $latitud, $longitud, $capacidad, $tipo, $horaApertura, $horaCierre)
    {
        $this->_db->prepare('insert into cementerio(nombre,latitud,longitud,capacidad,tipo,hora_apertura,hora_cierre,municipio_id_municipio)
    values(:nombre,:latitud,:longitud,:capacidad,:tipo,:horaApertura
    ,:horaCierre,:municipio)')->execute(array(
                    'nombre' => $nombre,
                    'latitud' => $latitud,
                    'longitud' => $longitud,
                    'capacidad' => $capacidad
                    ,
                    'tipo' => $tipo,
                    'horaApertura' => $horaApertura,
                    'horaCierre' => $horaCierre,
                    'municipio' => $municipio
                ));

    }

    public function actualizarCementerio($nombreUp, $municipioUp, $latitudUp, $longitudUp, $capacidadUp, $tipoUp, $horaAperturaUp, $horaCierreUp, $idCementerioUp)
    {
        $sql = 'UPDATE cementerio 
        SET nombre = :nombre, 
            latitud = :latitud, 
            longitud = :longitud, 
            capacidad = :capacidad, 
            tipo = :tipo, 
            hora_apertura = :hora_apertura, 
            hora_cierre = :hora_cierre, 
            municipio_id_municipio = :municipio 
        WHERE id_cementerio = :idCementerioUp';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombreUp,
            'latitud' => $latitudUp,
            'longitud' => $longitudUp,
            'capacidad' => $capacidadUp,
            'tipo' => $tipoUp,
            'hora_apertura' => $horaAperturaUp,
            'hora_cierre' => $horaCierreUp,
            'municipio' => $municipioUp,
            'idCementerioUp' => $idCementerioUp
        ));

    }

    public function borrarCementerio($idCementerio)
    {
        $this->_db->prepare('delete from cementerio where id_cementerio=:idCementerio')->execute(array('idCementerio' => $idCementerio));
    }




}
