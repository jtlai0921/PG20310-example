//
//  Shader.fsh
//  Prog09-01
//
//  Created by SAKAI Yuji on 10/03/20.
//  Copyright Apple Inc 2010. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
