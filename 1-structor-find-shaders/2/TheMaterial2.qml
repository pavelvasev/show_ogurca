PhongMaterial {
    id: p1

    property real time: theScene.sceneTime
    property real custom1: pCustom1.value / 10 // теперь custom1 и custom2 от 0 до 5
    property real custom2: pCustom2.value / 10

    vertexShader: "
        // your things
        uniform float time;
        uniform float custom1;
        uniform float custom2;
        
        // next things must be due to threejs
        varying vec2 vUv;
        varying vec3 vViewPosition;
        varying vec3 vNormal;         
        varying vec3 vColor;        
        
        void main()
        {
#ifdef USE_COLOR        
	        vColor.xyz = color.xyz;
#endif                  
          // MAIN CODE BEGIN
          //Get original position of the vertex
          vec3 v = position.xyz;
          //float phase = 0.0;			//Phase for sin function
          //float distortAmount = 0.25; //Amount of distorsion
          float phase = custom1;
          float distortAmount = custom2;

          //Compute value of distortion for current vertex
          float distort = distortAmount * sin( phase + 0.015 * v.z );
          
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
