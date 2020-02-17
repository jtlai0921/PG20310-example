//
//  Shader.fsh
//  Prog05-01
//
//  Created by SAKAI Yuji on 09/12/22.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
	gl_FragColor = colorVarying;
}
