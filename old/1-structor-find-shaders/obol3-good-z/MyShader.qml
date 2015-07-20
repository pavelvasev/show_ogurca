import components.show_points
Shader {
    id: p1

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
          // MAIN CODE BEGIN
          //Get original position of the vertex
          vec3 v = position.xyz;
          //Compute value of distortion for current vertex
          float c2m10=custom2;//-10.0;
          //float dist = distance( vec3(0.0,0.0,c2m10), v );
          float dist = pow( v.x*v.x + v.y*v.y, 0.5); //distance( vec3(0.0,0.0,custom2), v );

          //float distort = custom1 * sin( time + 0.015 * v.y );
          //float distort = dist*dist / (custom1+1.0);
          float distort = pow( dist / custom1, custom2 );//custom1/10.0 );

       	  v.x /= distort;
          v.y /= distort;
          //v.z /= distort;
          //v.z = (v.z - c2m10) / distort + c2m10;
                    
	        //float alfa = 0.01*distance( vec3(0.0,0.0,0.0), v );
          
          //Move the position
          /*
       	  v.x /= (0.1 + distort)*alfa;
          v.y /= (0.1 + distort)*alfa;
          v.z = (v.z - c2m10)/( (0.1 + distort)*alfa ) + c2m10;
          */

          gl_Position = vec4( v, 1.0);

          //float zz = position.z * sin(time*custom2/400.0);
          //float zz = position.z;
          //vec3 newposition = vec3(position.x + sin(time)*custom2, position.y + cos(time * custom1) * custom2, zz);
  
        }
     " // vertex shader code

}
