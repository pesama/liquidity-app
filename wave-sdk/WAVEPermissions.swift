/*
 Copyright 2010-2018 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */


import Foundation
import AWSCore


@objcMembers
public class WAVEPermissions : AWSModel {
    
    var archivable: NSNumber!
    var canBeAnchor: NSNumber!
    var canModifyCurrency: NSNumber!
    var canModifyDescription: NSNumber!
    var canModifyId: NSNumber!
    var canModifySubGroup: NSNumber!
    var canRename: NSNumber!
    var systemCreated: NSNumber!
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["archivable"] = "archivable"
		params["canBeAnchor"] = "can_be_anchor"
		params["canModifyCurrency"] = "can_modify_currency"
		params["canModifyDescription"] = "can_modify_description"
		params["canModifyId"] = "can_modify_id"
		params["canModifySubGroup"] = "can_modify_sub_group"
		params["canRename"] = "can_rename"
		params["systemCreated"] = "system_created"
		
        return params
	}
}
