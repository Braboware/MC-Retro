//jitter effect, kind of a mess

#include "/settings.glsl"
//#define XY_JITTER //Switch jitter from XZ-axes to XY-axes

varying vec4 color;

#ifndef EXCLUDE_TEXCOORD
    varying vec4 texcoord;
#endif

#ifndef EXCLUDE_LMCOORD
    varying vec4 lmcoord;
#endif

#ifdef ITEM
    uniform int entityId;
#endif

// for passing to frag shader for affine texture mapping
varying vec3 affine;

attribute vec3 mc_Entity;
varying float fix;


#ifdef HAND
    void main() {
        vec4 position = gl_ModelViewMatrix * gl_Vertex;
        #ifdef HAND_JITTER

            #ifdef XY_JITTER
                position.xy = floor(resolution * position.xy) / resolution; // one line for the effect!
            #else   
                position.xz = floor(resolution * position.xz) / resolution; // one line for the effect!
            #endif
            
            gl_Position = gl_ProjectionMatrix * position;
        #else
            gl_Position = ftransform();
        #endif
        
        // necessary junk
        color = gl_Color;
        texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
        lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
        
        affine = vec3(texcoord.st * position.z, position.z);
    }
#endif

#ifdef ITEM
    void main() {
        #ifdef ITEM_JITTER
        
            vec4 position = gl_ModelViewMatrix * gl_Vertex;
            
            #ifdef XY_JITTER
                position.xy = floor(resolution * position.xy) / resolution; // one line for the effect!
            #else
                position.xz = floor(resolution * position.xz) / resolution; // one line for the effect!
            #endif
            
            gl_Position = gl_ProjectionMatrix * position;
        #else
            vec4 position = gl_ModelViewMatrix * gl_Vertex;
            
            #ifdef XY_JITTER
                if (entityId == 1)
                    position.xy = floor(resolution * position.xy) / resolution; // one line for the effect!
            #else
                if (entityId == 1)
                    position.xz = floor(resolution * position.xz) / resolution; // one line for the effect!
            #endif
            
            gl_Position = gl_ProjectionMatrix * position;
        #endif
        
        // necessary junk
        color = gl_Color;
        texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
        lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
        gl_FogFragCoord = gl_Position.z;
        
        affine = vec3(texcoord.st * position.z, position.z);
    }
#endif

#if !defined HAND && !defined ITEM
    void main() {
        vec4 position = gl_ModelViewMatrix * gl_Vertex;
        
        #ifdef XY_JITTER
            position.xy = floor(resolution * position.xy) / resolution;
        #else   
            position.xz = floor(resolution * position.xz) / resolution;
        #endif
        
        gl_Position = gl_ProjectionMatrix * position;
        
        color = gl_Color;
        
        #ifndef EXCLUDE_TEXCOORD
            texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
        #endif
        
        #ifndef EXCLUDE_LMCOORD
            lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
        #endif
        
        gl_FogFragCoord = gl_Position.z;
        
        #ifndef SKYBASIC
            affine = vec3(texcoord.st * position.z, position.z);
        #endif
        
        //block IDs "incompatible" with affine mapping (really wish they stuck with numeric ids, finding new ids is trial and error)
        //---------------------------------------------------
        //soul torch            -1 (like why?)(wiki says 523 but they're LYING)
        //sapling               6
        //dead bush             32
        //dandelion             37
        //flowers               38
        //brown mushroom        39
        //red mushroom          40
        //torch                 50
        //redstone torch off    75
        //redstone torch        76
        //sunflower             175
        
        fix = 0.;
        #ifdef affine_fix
            //pass block info to fragment shader
            float arr[] = {-1., 6., 32., 37., 38., 39., 40., 50., 75., 76., 175.};
            for(int i = 0; i < arr.length(); i++){
                if(arr[i] == mc_Entity.x){
                    fix = 1.;
                    break;
                }
            }
        #endif
        
        
        /* "what's that new id?" debug hell
        if (mc_Entity.x >= 0.0)
            fix = 1.;
        else
            fix = 0.;
        */
        
        
    }
#endif