//
//  Shader.vsh
//  Prog06-02
//
//  Created by SAKAI Yuji on 10/01/08.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
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
