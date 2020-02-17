//
//  Shader.vsh
//  Prog09-01
//
//  Created by SAKAI Yuji on 10/03/20.
//  Copyright Apple Inc 2010. All rights reserved.
//

attribute vec4 position;
attribute vec4 color;

varying vec4 colorVarying;

uniform float translate;

void main()
{
    gl_Position = position;
    gl_Position.y += sin(translate) / 2.0;

    colorVarying = color;
}
