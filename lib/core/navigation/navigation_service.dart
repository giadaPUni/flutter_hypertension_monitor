import 'package:flutter/material.dart'; 

class NavigationService {

    NavigationService() : _navigationKey = GlobalKey<NavigatorState>(); 

    @visibleForTesting
    NavigationService.private(
        this._navigationKey,
    ); 

    final GlobalKey<NavigatorState> _navigationKey; 

    GlobalKey<NavigatorState> get navigationKey => _navigationKey; 

    Future<T?> navigateTo<T>(
        String routeName, {
            Object? arguments,
        }
    ) {
        return _navigationKey.currentState!
            .pushNamed<T>(
                routeName, 
                arguments: arguments, 
            ); 
    }

    void pop<T>({
        T? result, 
    }) {
        _navigationKey.currentState!
            .pop(result); 
    }

    Future<T?> navigateToMaterialRoute<T>(
        WidgetBuilder builder, {
            bool fullscreenDialog = false, 
        }
    ) {
        return _navigationKey.currentState! 
            .push<T>(
                MaterialPageRoute(
                    builder: builder, 
                    fullscreenDialog: fullscreenDialog,
                ),
            ); 
    }

    Future<T?> replaceWith<T>(
        String routeName, {
            Object? arguments, 
        }
    ) {
        return _navigationKey.currentState! 
            .pushReplacementNamed<T, Object?>(
                routeName, 
                arguments: arguments, 
            );
    }

    Future<T?> navigateAndRemoveUntil<T>(
        String routeName, {
            Object? arguments, 
        }
    ) {
        return _navigationKey.currentState!
            .pushNamedAndRemoveUntil<T>(
                routeName, 
                (route) => false, 
                arguments: arguments, 
            ); 
    }


}