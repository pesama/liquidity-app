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
public class WAVETransaction : AWSModel {
    
    var anchorAccountName: String!
    var dateCreated: String!
    var direction: WAVEGroup!
    var isCreditCardPayment: NSNumber!
    var lineItemAccountNames: [String]!
    var quickCategorization: WAVETransactionCategorization!
    var sequence: NSNumber!
    var sortKey: [NSNumber]!
    var transactionDate: String!
    var transactionDescription: String!
    var transactionGuid: String!
    var transactionStatus: WAVEGroup!
    var transactionTotal: WAVETransactionTotal!
    var transactionType: WAVEGroup!
    
   	public override static func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]!{
		var params:[AnyHashable : Any] = [:]
		params["anchorAccountName"] = "anchor_account_name"
		params["dateCreated"] = "date_created"
		params["direction"] = "direction"
		params["isCreditCardPayment"] = "is_credit_card_payment"
		params["lineItemAccountNames"] = "line_item_account_names"
		params["quickCategorization"] = "quick_categorization"
		params["sequence"] = "sequence"
		params["sortKey"] = "sort_key"
		params["transactionDate"] = "transaction_date"
		params["transactionDescription"] = "transaction_description"
		params["transactionGuid"] = "transaction_guid"
		params["transactionStatus"] = "transaction_status"
		params["transactionTotal"] = "transaction_total"
		params["transactionType"] = "transaction_type"
		
        return params
	}
	class func directionJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
	class func quickCategorizationJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVETransactionCategorization.self);
	}
	class func transactionStatusJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
	class func transactionTotalJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVETransactionTotal.self);
	}
	class func transactionTypeJSONTransformer() -> ValueTransformer{
	    return ValueTransformer.awsmtl_JSONDictionaryTransformer(withModelClass: WAVEGroup.self);
	}
}
