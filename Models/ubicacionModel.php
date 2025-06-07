<?php

class ubicacionModel extends Model
{

    public function obtenerCementerios()
    {
        return $this->_db->query("select *from cementerio;")->fetchAll();
    }

    public function obtenerAsignados(){
        return $this->_db->query("    
    SELECT 
        d.*,u.*
        FROM 
        ubicacion_descanso u
        Inner JOIN 
        defunciones d ON d.id_defuncion = u.defuncion_id_defuncion;")->fetchAll();
    }

    public function obtenerUbicacion()
    {
        return $this->_db->query("SELECT 
    d.*
    FROM 
    defunciones d
   
    LEFT JOIN 
    ubicacion_descanso u ON d.id_defuncion = u.defuncion_id_defuncion
    WHERE 
    u.defuncion_id_defuncion IS NULL;")->fetchAll();
    }

    

    public function insertarUbicacion($idFallecio, $cementerio, $lat,$long, $descr,$imagen)
    {

        $this->_db->prepare('insert into ubicacion_descanso(latitud, longitud, descripcion_lugar, defuncion_id_defuncion, cementerio_id_cementerio, imagen_descanso)
    values(:latitud, :longitud, :descr, :idFallecio, :cementerio, :foto)')->execute(array(
                    'latitud' => $lat,
                    'longitud' => $long,
                    'descr' => $descr,
                    'idFallecio' => $idFallecio,
                    'cementerio' => $cementerio,
                    'foto' => $imagen

                ));

    }

    public function actualizarUbicacion($idUbi, $cementerio, $lat,$long, $descr,$idDef)
    {
        $sql = 'UPDATE ubicacion_descanso 
        SET latitud = :lat,
        longitud = :long,
        descripcion_lugar = :descr,
        defuncion_id_defuncion = :def,
        cementerio_id_cementerio = :cem

        WHERE id_ubicacion = :id';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'lat' => $lat,
            'long' => $long,
            'descr' => $descr,
            'def' => $idDef,
            'cem' => $cementerio,
            'id' => $idUbi

        ));

    }

    public function borrarUbicacion($id)
    {
        $this->_db->prepare('delete from ubicacion_descanso where id_ubicacion=:id')->execute(array('id' => $id));
    }




}
