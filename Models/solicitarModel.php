<?php

class solicitarModel extends Model
{

    public function obtenerSolicitud()
    {
        return $this->_db->query("
select *from servicio_mantenimiento inner join ubicacion_descanso on id_ubicacion=ubicacion_descanso_id;")->fetchAll();
    }

    public function obtenerServicios()
    {
        return $this->_db->query("select *from servicio;")->fetchAll();
    }

    public function obtenerDatosFamiliar($usuario)
    {
        return $this->_db->query("select *from familiar where usuario='$usuario';")->fetchAll();
    }

    public function obtenerDefuncion($id)
    {
        return $this->_db->query("select * from defunciones inner join ubicacion_descanso on id_defuncion=defuncion_id_defuncion  where id_defuncion='$id';")->fetchAll();
    }

    public function obtenerDescanso($id)
    {
        return $this->_db->query("select * from defunciones inner join ubicacion_descanso on id_defuncion=defuncion_id_defuncion  where id_defuncion='$id';")->fetchAll();
    }


    public function insertarSolicitud($servicio,$ubicacion,$dia,$otro,$estado)
    {
       
        $this->_db->prepare('insert into servicio_mantenimiento(ubicacion_descanso_id,servicio_id_servicio,fecha_servicio,estado,observaciones) 
    values(:ubicacion,:servicio,:fecha,:estado,:observacion)')->execute(array(
                    'ubicacion' => $ubicacion,
                    'servicio' => $servicio,
                    'fecha' => $dia,
                    'estado' => $estado,
                    'observacion'=> $otro
                    
                ));

    }
  



}
