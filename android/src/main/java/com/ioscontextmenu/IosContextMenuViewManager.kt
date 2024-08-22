package com.ioscontextmenu

import android.graphics.Color
import com.facebook.react.module.annotations.ReactModule
import com.facebook.react.uimanager.SimpleViewManager
import com.facebook.react.uimanager.ThemedReactContext
import com.facebook.react.uimanager.ViewManagerDelegate
import com.facebook.react.uimanager.annotations.ReactProp
import com.facebook.react.viewmanagers.IosContextMenuViewManagerInterface
import com.facebook.react.viewmanagers.IosContextMenuViewManagerDelegate

@ReactModule(name = IosContextMenuViewManager.NAME)
class IosContextMenuViewManager : SimpleViewManager<IosContextMenuView>(),
  IosContextMenuViewManagerInterface<IosContextMenuView> {
  private val mDelegate: ViewManagerDelegate<IosContextMenuView>

  init {
    mDelegate = IosContextMenuViewManagerDelegate(this)
  }

  override fun getDelegate(): ViewManagerDelegate<IosContextMenuView>? {
    return mDelegate
  }

  override fun getName(): String {
    return NAME
  }

  public override fun createViewInstance(context: ThemedReactContext): IosContextMenuView {
    return IosContextMenuView(context)
  }

  @ReactProp(name = "color")
  override fun setColor(view: IosContextMenuView?, color: String?) {
    view?.setBackgroundColor(Color.parseColor(color))
  }

  companion object {
    const val NAME = "IosContextMenuView"
  }
}
