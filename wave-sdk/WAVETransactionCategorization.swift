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
public class WAVETransactionCategorization : AWSModel {
    
    var accountGuid: String!
    var accountName: String!
    var anchorAccountGuid: String!
    var anchorItemType: WAVEGroup!
    var categorizationType: String!
    var itemType: WAVEGroup!
    var order: NSNumber!
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["accountGuid"] = "account_guid"
		params["accountName"] = "account_name"
		params["anchorAccountGuid"] = "anchor_account_guid"
		params["anchorItemType"] = "anchor_item_type"
		params["categorizationType"] = "categorization_type"
		params["itemType"] = "item_type"
		params["order"] = "order"
		
        return params
	}
	class func anchorItemTypeJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
	class func itemTypeJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
}
