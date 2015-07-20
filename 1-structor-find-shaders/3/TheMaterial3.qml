PhongMaterial {
    id: p1

    property real time: theScene.sceneTime
    property real custom1: pCustom1.value / 20 // теперь custom1 и custom2 от 0 до 5
    property real custom2: pCustom2.value / 20

    vertexShader: "
        // your things
        uniform float time;
        uniform float custom1;
        uniform float custom2;
        
        // next things must be due to threejs
        varying vec2 vUv;
        varying vec3 vViewPosition;
        varying vec3 vNormal;         

        void main()
        {
          // MAIN CODE BEGIN
          //Get original position of the vertex
          vec3 v = position.xyz;
          //Compute value of distortion for current vertex
          float dist = distance( vec3(0.0,0.0,custom2), v );

          //float distort = custom1 * sin( time + 0.015 * v.y );
          float distort = custom1 * dist;
          
          //Move the position
         	v.x /= 1.0 + distort;
	        v.y /= 1.0 + distort;
          v.z /= 1.0 + distort;          

          vec3 newposition = v;

          //float zz = position.z * sin(time*custom2/400.0);
          //float zz = position.z;
          //vec3 newposition = vec3(position.x + sin(time)*custom2, position.y + cos(time * custom1) * custom2, zz);
  
          // MAIN CODE END
        
          // ***************  standard threejs conversion
          vec4 mvPosition = modelViewMatrix * vec4( newposition, 1.0 );
          gl_Position = projectionMatrix * mvPosition;
          //gl_Position = vec4( position, 1.0 );
        
          // ***************  next things must be due to PhongMaterial
          vViewPosition = -mvPosition.xyz;
          vec3 objectNormal = normal;
          vec3 transformedNormal = normalMatrix * objectNormal;
          vNormal = normalize( transformedNormal );
          vUv = uv;
        }
     " // vertex shader code

}
