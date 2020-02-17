//
//  Shader.fsh
//  Prog02-06
//
//  Created by SAKAI Yuji on 10/03/12.
//  Copyright Apple Inc 2010. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
