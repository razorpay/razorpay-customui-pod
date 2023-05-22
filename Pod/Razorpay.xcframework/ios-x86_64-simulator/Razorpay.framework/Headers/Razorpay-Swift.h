#if 0
#elif defined(__x86_64__) && __x86_64__
// Generated by Apple Swift version 5.8 (swiftlang-5.8.0.124.2 clang-1403.0.22.11.100)
#ifndef RAZORPAY_SWIFT_H
#define RAZORPAY_SWIFT_H
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#if defined(__OBJC__)
#include <Foundation/Foundation.h>
#endif
#if defined(__cplusplus)
#include <cstdint>
#include <cstddef>
#include <cstdbool>
#include <cstring>
#include <stdlib.h>
#include <new>
#include <type_traits>
#else
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>
#endif
#if defined(__cplusplus)
#if __has_include(<ptrauth.h>)
# include <ptrauth.h>
#else
# ifndef __ptrauth_swift_value_witness_function_pointer
#  define __ptrauth_swift_value_witness_function_pointer(x)
# endif
#endif
#endif

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...) 
# endif
#endif
#if !defined(SWIFT_RUNTIME_NAME)
# if __has_attribute(objc_runtime_name)
#  define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
# else
#  define SWIFT_RUNTIME_NAME(X) 
# endif
#endif
#if !defined(SWIFT_COMPILE_NAME)
# if __has_attribute(swift_name)
#  define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
# else
#  define SWIFT_COMPILE_NAME(X) 
# endif
#endif
#if !defined(SWIFT_METHOD_FAMILY)
# if __has_attribute(objc_method_family)
#  define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
# else
#  define SWIFT_METHOD_FAMILY(X) 
# endif
#endif
#if !defined(SWIFT_NOESCAPE)
# if __has_attribute(noescape)
#  define SWIFT_NOESCAPE __attribute__((noescape))
# else
#  define SWIFT_NOESCAPE 
# endif
#endif
#if !defined(SWIFT_RELEASES_ARGUMENT)
# if __has_attribute(ns_consumed)
#  define SWIFT_RELEASES_ARGUMENT __attribute__((ns_consumed))
# else
#  define SWIFT_RELEASES_ARGUMENT 
# endif
#endif
#if !defined(SWIFT_WARN_UNUSED_RESULT)
# if __has_attribute(warn_unused_result)
#  define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
# else
#  define SWIFT_WARN_UNUSED_RESULT 
# endif
#endif
#if !defined(SWIFT_NORETURN)
# if __has_attribute(noreturn)
#  define SWIFT_NORETURN __attribute__((noreturn))
# else
#  define SWIFT_NORETURN 
# endif
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA 
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA 
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA 
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif
#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif
#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER 
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility) 
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED_OBJC)
# if __has_feature(attribute_diagnose_if_objc)
#  define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
# else
#  define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
# endif
#endif
#if defined(__OBJC__)
#if !defined(IBSegueAction)
# define IBSegueAction 
#endif
#endif
#if !defined(SWIFT_EXTERN)
# if defined(__cplusplus)
#  define SWIFT_EXTERN extern "C"
# else
#  define SWIFT_EXTERN extern
# endif
#endif
#if !defined(SWIFT_CALL)
# define SWIFT_CALL __attribute__((swiftcall))
#endif
#if !defined(SWIFT_INDIRECT_RESULT)
# define SWIFT_INDIRECT_RESULT __attribute__((swift_indirect_result))
#endif
#if !defined(SWIFT_CONTEXT)
# define SWIFT_CONTEXT __attribute__((swift_context))
#endif
#if !defined(SWIFT_ERROR_RESULT)
# define SWIFT_ERROR_RESULT __attribute__((swift_error_result))
#endif
#if defined(__cplusplus)
# define SWIFT_NOEXCEPT noexcept
#else
# define SWIFT_NOEXCEPT 
#endif
#if defined(_WIN32)
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL __declspec(dllimport)
#endif
#else
#if !defined(SWIFT_IMPORT_STDLIB_SYMBOL)
# define SWIFT_IMPORT_STDLIB_SYMBOL 
#endif
#endif
#if defined(__OBJC__)
#if __has_feature(objc_modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import Foundation;
@import ObjectiveC;
#endif

#endif
#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"
#pragma clang diagnostic ignored "-Wdollar-in-identifier-extension"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="Razorpay",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif

#if defined(__OBJC__)
@class WKWebView;
@class NSString;
@class WKNavigation;

SWIFT_CLASS("_TtC8Razorpay6Otpelf")
@interface Otpelf : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
+ (void)initWithWebView:(WKWebView * _Nonnull)webView andMerchantKey:(NSString * _Nullable)merchantKey SWIFT_METHOD_FAMILY(none);
+ (Otpelf * _Nullable)getSharedInstance SWIFT_WARN_UNUSED_RESULT;
- (void)setPaymentData:(NSDictionary * _Nonnull)data;
- (BOOL)webViewWithDidFinish:(WKNavigation * _Null_unspecified)navigation error:(NSError * _Nullable * _Nullable)error;
- (void)close;
@end

@class PluginPaymentModel;

SWIFT_PROTOCOL("_TtP8Razorpay21PluginPaymentDelegate_")
@protocol PluginPaymentDelegate
- (BOOL)canProcessPaymentWithModel:(PluginPaymentModel * _Nonnull)model SWIFT_WARN_UNUSED_RESULT;
- (NSString * _Nonnull)identifier SWIFT_WARN_UNUSED_RESULT;
- (void)payWithModel:(PluginPaymentModel * _Nonnull)model;
@optional
- (void)getExternalPaymentDataWithMobileNumber:(NSString * _Nonnull)mobileNumber handler:(void (^ _Nonnull)(void))handler;
- (NSArray<NSDictionary *> * _Nonnull)paymentData SWIFT_WARN_UNUSED_RESULT;
@end


SWIFT_CLASS("_TtC8Razorpay18PluginPaymentModel")
@interface PluginPaymentModel : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@protocol UPITurboPlugin;
@protocol RazorpayPaymentCompletionProtocol;
@class NSURL;

SWIFT_CLASS("_TtC8Razorpay16RazorpayCheckout")
@interface RazorpayCheckout : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@property (nonatomic, strong) id <UPITurboPlugin> _Nullable upiTurbo;
+ (RazorpayCheckout * _Nonnull)initWithKey:(NSString * _Nonnull)key andDelegate:(id <RazorpayPaymentCompletionProtocol> _Nonnull)delegate withPaymentWebView:(WKWebView * _Nonnull)merchantWebView SWIFT_METHOD_FAMILY(none) SWIFT_WARN_UNUSED_RESULT;
+ (RazorpayCheckout * _Nonnull)initWithKey:(NSString * _Nonnull)key andDelegate:(id <RazorpayPaymentCompletionProtocol> _Nonnull)delegate withPaymentWebView:(WKWebView * _Nonnull)merchantWebView plugin:(id <UPITurboPlugin> _Nonnull)plugin SWIFT_METHOD_FAMILY(none) SWIFT_WARN_UNUSED_RESULT;
- (void)changeApiKey:(NSString * _Nonnull)newApiKey;
- (void)payWithCredWithOptions:(NSDictionary * _Nonnull)options withSuccessCallback:(void (^ _Nonnull)(NSDictionary * _Nonnull))success andFailureCallback:(void (^ _Nonnull)(NSString * _Nonnull))failure;
- (void)getCardFlows:(NSDictionary * _Nonnull)options withCallback:(void (^ _Nonnull)(BOOL))withCallback;
- (void)getCardOtpDataWithResponse:(void (^ _Nonnull)(BOOL))response;
- (void)submitOtpWithOtp:(NSString * _Nonnull)otp;
- (void)resendOtpWithResponse:(void (^ _Nonnull)(BOOL))response;
- (void)redirectToBankPage;
- (void)getPaymentMethodsWithOptions:(NSDictionary * _Nullable)options withSuccessCallback:(void (^ _Nonnull)(NSDictionary * _Nonnull))success andFailureCallback:(void (^ _Nonnull)(NSString * _Nonnull))failure;
- (void)getSubscriptionAmountWithHavingSubscriptionId:(NSString * _Nonnull)subId withSuccessCallback:(void (^ _Nonnull)(uint64_t))success andFailureCallback:(void (^ _Nonnull)(NSString * _Nonnull))failure;
- (void)getSubscriptionAmountWithOptions:(NSDictionary * _Nonnull)options withSuccessCallback:(void (^ _Nonnull)(uint64_t))success andFailureCallback:(void (^ _Nonnull)(NSString * _Nonnull))failure;
- (void)authorize:(NSDictionary * _Nonnull)options;
- (void)setWebView:(WKWebView * _Nonnull)webView;
- (void)authorize:(NSDictionary * _Nonnull)options paymentPlugin:(id <PluginPaymentDelegate> _Nonnull)paymentPlugin;
- (void)openCheckoutWithDict:(NSDictionary * _Nonnull)dict;
- (void)userCancelledPayment;
- (void)decodeURIFrom:(NSString * _Nonnull)data;
- (void)close;
- (void)webView:(WKWebView * _Nonnull)webView didCommit:(WKNavigation * _Null_unspecified)navigation;
- (void)webView:(WKWebView * _Nonnull)webView didFailProvisionalNavigation:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)er;
- (void)webView:(WKWebView * _Nonnull)webView didFail:(WKNavigation * _Null_unspecified)navigation withError:(NSError * _Nonnull)er;
- (void)webView:(WKWebView * _Nonnull)webView didFinish:(WKNavigation * _Null_unspecified)navigation;
- (NSString * _Nonnull)getCardNetworkFromCardNumber:(NSString * _Nonnull)cardNumber SWIFT_WARN_UNUSED_RESULT;
- (NSArray<NSString *> * _Nonnull)getSupportedUPIApps SWIFT_WARN_UNUSED_RESULT SWIFT_DEPRECATED_MSG("use getAppsWhichSupportUpi(handler:) instead");
+ (void)getAppsWhichSupportUpiWithHandler:(void (^ _Nonnull)(NSArray<NSDictionary *> * _Nonnull))handler;
- (BOOL)isCardValid:(NSString * _Nonnull)cardNumber SWIFT_WARN_UNUSED_RESULT;
- (void)isValidVpa:(NSString * _Nonnull)vpa withSuccessCallback:(void (^ _Nonnull)(NSDictionary * _Nonnull))success withFailure:(void (^ _Nonnull)(NSDictionary * _Nonnull))failure;
- (NSInteger)getCardNetworkLengthOfNetwork:(NSString * _Nonnull)network SWIFT_WARN_UNUSED_RESULT;
- (NSURL * _Nullable)getBankLogoWithHavingBankCode:(NSString * _Nonnull)bankCode SWIFT_WARN_UNUSED_RESULT;
- (NSURL * _Nullable)getWalletSqLogoWithHavingWalletName:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (NSURL * _Nullable)getWalletLogoWithHavingWalletName:(NSString * _Nonnull)name SWIFT_WARN_UNUSED_RESULT;
- (void)payWithExternalPaymentEntityWithOptions:(NSDictionary * _Nonnull)options arrExternalPaymentEntities:(NSArray<id <PluginPaymentDelegate>> * _Nonnull)arrExternalPaymentEntities;
- (void)publishUriWith:(NSString * _Nonnull)data;
@end


SWIFT_PROTOCOL("_TtP8Razorpay33RazorpayPaymentCompletionProtocol_")
@protocol RazorpayPaymentCompletionProtocol
- (void)onPaymentSuccess:(NSString * _Nonnull)payment_id andData:(NSDictionary * _Nonnull)response;
- (void)onPaymentError:(int32_t)code description:(NSString * _Nonnull)str andData:(NSDictionary * _Nonnull)response SWIFT_DEPRECATED_MSG("this function will accept a code of Type Int and not Int32 in future releases");
@end




SWIFT_PROTOCOL("_TtP8Razorpay14UPITurboPlugin_")
@protocol UPITurboPlugin
@property (nonatomic, readonly, strong) id <PluginPaymentDelegate> _Nonnull paymentPlugin;
- (void)getLinkedAccountsWithMobileNumber:(NSString * _Nonnull)mobileNumber resultDelegate:(id _Nonnull)resultDelegate;
- (void)linkNewAccountWithMobileNumber:(NSString * _Nonnull)mobileNumber linkActionDelegate:(id _Nonnull)linkActionDelegate;
- (void)fetchAccountBalanceWithUpiAccount:(id _Nullable)upiAccount handler:(void (^ _Nonnull)(id _Nullable, NSError * _Nullable))handler;
- (void)resetUpiPinWithUpiAccount:(id _Nullable)upiAccount card:(id _Nonnull)card handler:(void (^ _Nonnull)(id _Nullable, NSError * _Nullable))handler;
- (void)delinkVpaWithUpiAccount:(id _Nullable)upiAccount handler:(void (^ _Nonnull)(id _Nullable, NSError * _Nullable))handler;
- (void)changeUpiPinWithUpiAccount:(id _Nullable)upiAccount handler:(void (^ _Nonnull)(id _Nullable, NSError * _Nullable))handler;
@end


SWIFT_PROTOCOL("_TtP8Razorpay16UPITurboUIPlugin_")
@protocol UPITurboUIPlugin
@property (nonatomic, readonly, strong) id <UPITurboPlugin> _Nullable corePlugin;
@property (nonatomic, readonly, strong) id <PluginPaymentDelegate> _Nullable paymentPlugin;
- (void)linkNewUpiAccountWithCompletionHandler:(void (^ _Nonnull)(id _Nullable, NSError * _Nullable))completionHandler;
- (void)manageUpiAccount;
- (NSArray<NSDictionary *> * _Nullable)getupiAccountObjectWithUpiAccounts:(id _Nullable)upiAccounts SWIFT_WARN_UNUSED_RESULT;
@end

#endif
#if defined(__cplusplus)
#endif
#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop
#endif

#else
#error unsupported Swift architecture
#endif
