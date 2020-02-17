//
//  Shader.fsh
//  Prog07-02
//
//  Created by SAKAI Yuji on 10/02/05.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
	gl_FragColor = colorVarying;
}
