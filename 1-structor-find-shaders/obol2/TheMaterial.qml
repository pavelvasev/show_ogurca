import components.show_points
PhongMaterial {
    id: p1

    property real time: theScene.sceneTime
    property real custom1: pCustom1.value 
    property real custom2: pCustom2.value 

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
          // MAIN CODE BEGIN
          //Get original position of the vertex
          vec3 v = position.xyz;
          //Compute value of distortion for current vertex
          float c2m10=custom2;//-10.0;
          float dist = distance( vec3(0.0,0.0,c2m10), v );
          //float dist = v.x*v.x + v.y*v.y; //distance( vec3(0.0,0.0,custom2), v );

          //float distort = custom1 * sin( time + 0.015 * v.y );
          float distort = dist*dist / (custom1+1.0);
          //float distort = pow( dist, 2.0 );//custom1/10.0 );

       	  v.x /= distort;
          v.y /= distort;
          //v.z /= distort;
          v.z = (v.z - c2m10) / distort + c2m10;
                    
	        //float alfa = 0.01*distance( vec3(0.0,0.0,0.0), v );
          
          //Move the position
          /*
       	  v.x /= (0.1 + distort)*alfa;
          v.y /= (0.1 + distort)*alfa;
          v.z = (v.z - c2m10)/( (0.1 + distort)*alfa ) + c2m10;
          */

          vec3 newposition = v;

          //float zz = position.z * sin(time*custom2/400.0);
          //float zz = position.z;
          //vec3 newposition = vec3(position.x + sin(time)*custom2, position.y + cos(time * custom1) * custom2, zz);
  
          // MAIN CODE END

#ifdef USE_COLOR        
	        vColor.xyz = color.xyz;
#endif          
        
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
