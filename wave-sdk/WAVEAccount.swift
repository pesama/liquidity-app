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
public class WAVEAccount : AWSModel {
    
    var accountName: String!
    var active: NSNumber!
    var archived: NSNumber!
    var businessId: String!
    var currencyCode: String!
    var _description: String!
    var group: WAVEGroup!
    var guid: String!
    var metadata: String!
    var normalBalanceType: WAVEGroup!
    var permissions: WAVEPermissions!
    var sequence: NSNumber!
    var subGroup: WAVEGroup!
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["accountName"] = "account_name"
		params["active"] = "active"
		params["archived"] = "archived"
		params["businessId"] = "business_id"
		params["currencyCode"] = "currency_code"
		params["_description"] = "description"
		params["group"] = "group"
		params["guid"] = "guid"
		params["metadata"] = "metadata"
		params["normalBalanceType"] = "normal_balance_type"
		params["permissions"] = "permissions"
		params["sequence"] = "sequence"
		params["subGroup"] = "sub_group"
		
        return params
	}
	class func groupJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
	class func normalBalanceTypeJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
	class func permissionsJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEPermissions.self);
	}
	class func subGroupJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
}
