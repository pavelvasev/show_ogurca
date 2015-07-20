Shader {
    id: p1

  Param {
    id: pCustom1
    text: "Shake X-Amplitude"
    min: 0
    max: 5
    value: 1
    step: 0.1    
  }  

  Param {
    id: pCustom2
    text: "Shake Radius"
    min: 0
    max: 5
    value: 0
    step: 0.1
    color: "red"
  }    
    
    
    property real time: theScene.sceneTime
    property real custom1: pCustom1.value 
    property real custom2: pCustom2.value 

    vertex: "
        // your things
        uniform float time;
        uniform float custom1;
        uniform float custom2;

        void main()
        {
          //float zz = position.z * sin(time*custom2/400.0);
          float zz = gl_Position.z;
          vec3 newposition = vec3(gl_Position.x + sin(time)*custom2, gl_Position.y + cos(time * custom1) * custom2, zz);
          gl_Position = vec4( newposition, 1.0 );
        }
     " // vertex shader code

}
