//
//  Shader.fsh
//  Prog07-01
//
//  Created by SAKAI Yuji on 10/01/14.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
	gl_FragColor = colorVarying;
}
