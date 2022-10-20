# TODO

See [TODO-Archive](./TODO-Archive.md) for the old completed tasks + version history.

<br>

- [ ] **Cleanup**: Remove print logs.

<br>

- [ ] **Docs**: Update documentation sections
	* Remove numbered subsections.
	
	* Move links to files out of the section title.
	* Temporarily strip out links to section (i.e. replace with `PLACEHOLDER_LINK`).
	* Add versions table.
	* Remove collapsable sections.

<br>

- [ ] **Implement**: Add support for targeted previews on text (i.e. similar to safari). 
- [ ] **Implement**: Subscribe to `ContextMenuView` events via event emitter from context.

<br>

- [ ] **Task**: Read apple documentation to find any new changes added.

- [ ] **Refactor**: Make classes public and accessible outside the library.

	<br>

- [ ] **Refactor**: Extract types/components from `RNIWrapperView` to separate files.

- [ ] **Docs**: Add documentation for "Context Menu Preview Auxiliary View".

- [ ] **Refactor**: Move event-related types to their respective files where they're first used.

- [ ] **Refactor**: Update Access Modifiers for Classes/Structs — Make classes/structs public so they can be imported by other code.

- [ ] **Docs**: Update version history.

- [ ] **Refactor**: Use `react-native-ios-utilities`. 

<br>

- [ ] **Test**: Try to re-produce the bug where the context menu no longer works after a certain period of time

	* React Native Version: `0.63.4`

	* Hide app, wait 1 minute,  reopen app, then test context menu
		* Test on production mode + simulator: OK
		* Test on production mode + Debug Off + simulator: OK
		* Test on Production + No Xcode + Simulator: OK

	* Hide app, open contacts, wait 1 minute, reopen app, then test context menu
		* Test on production mode + simulator: OK
			* Test  on production mode + Debug Off + simulator: OK
			* Test on Production + No Xcode + Simulator: OK

<br>

- [ ] **Bugfix**: Running on device + production crashes immediately when context menu is invoked.
	* Might be a problem with Xcode beta — Running on iOS 16 simulator works fine on both production mode and debug mode.
	* Xcode beta + running on device (iPhone XR + iOS 15.1) causes crashes when the context menu is being created (i.e. `UIContextMenuConfiguration`).
	* Xcode 13 + running on device (iPhone XR + iOS 15.1) works fine.
	* Maybe the constructor for `UIContextMenuConfiguration` was changed?
		* Still crashes when `nil` is provided as an argument to all the parameters in the constructor.
		* Using the constructor that takes no arguments doesn't trigger a crash.

<br>

- [ ] **Implement**: Provide a default config for `previewConfig` when a `renderPreview` prop is given a value so that there's a default behavior.
- [ ] Expose `location(in:)`
- [ ] Implement: Re-write image loading logic for `IMAGE_REQUIRE`.
	* Move image loading in the background.
	* Add option for: lazy loading.
	* Add option for: synchronous loading.
	* Add option for: image caching.

<br>

- [ ] Implement: iOS 16

  - [ ] `UIMenuLeaf`
  - [ ] Maybe: `UIEditMenu`

<br>

- [ ] **Refactor**: Fabric re-write
	- [ ] **Task**: Create a test library — Playground for making a C++ turbo native module.
		- [x] **Task**: Figure out how to install `react-native-codegen`.
			* **Note**: For some weird reason, spaces and special characters in the working directory results in the CLI not finding the module location.
			
		- [x] **Task**: Figure out how to setup "code gen" in the library package, i.e. `codegenConfig`.
		
		- [x] **Task**: Create a turbo native module function.
			
			* Run the codegen script: `node ./example/node_modules/react-native/scripts/generate-artifacts.js --path ./example --outputPath ./example/ios`
				* Error: `[Codegen] >>>>> Searching for codegen-enabled libraries in react-native.config.js`
					* `Cannot find module 'example/react-native.config.js'` — The react-native codegen script cannot locate the `react-native.config.js` file.
					* The `example/react-native.config.js` file exists. Could this be a bug?
					* The `example/node_modules/react-native/scripts/generate-artifacts.js` executes  `example/node_modules/react-native/scripts/codegen/generate-artifacts-executor.js`
					* Line 219: `const rnConfigFilePath = path.join(appRootDir, rnConfigFileName);` — change `path.join` to `path.resolve`, i.e. `const rnConfigFilePath = path.resolve(appRootDir, rnConfigFileName);`.
					* Script now runs. It now generates a `build/generated/ios` directory containing the dependencies for fabric + turbomodules, as well as c++ artifact generated from our js spec — i.e. `RNIosCxxTestSpec`.
						* The directory contains a header file: `RNIosCxxTestSpec.h`, and an impl. file: `RNIosCxxTestSpec-generated.mm`.
			
			- Build Error: No member named `RNIosCxxTestSpec` in namespace `facebook::react`
			  * The corresponding module spec in `React-Codegen` was created properly.
			
			  * Could possibly be a naming issue?
			    * The js module file is named: `NativeIosCxxTest` — it follows the `Native<MODULE_NAME>` naming convention.
			    * The module is named: `IosCxxTest`
			
			  * Fixed by importing the codegen module header, e.g.: `#import <RNIosCxxTestSpec/RNIosCxxTestSpec.h>`.
			
			  * `RCT_EXPORT_MODULE` —  The `getTurboModule` function expects an instance of `facebook::react::TurboModule`. 
			
			  	* In this function, we must return the corresponding `RCTTurboModule` instance generated via codegen based on our JS spec.
			  	* For this project, it is in `React-Codegen/RNIosCxxTestSpec`.
			
			  	
			
		- [ ] **Task**: Call swif
		
		- [ ] **Task**: Make TNM function iOS-only
		
		  *  What is the best way to do this? One way is to create a dummy no-op/empty implementation for android.
		  	* What happens when there is a mismatch with the TNM declaration between iOS and Android? 
		  	* Will the "codegen" CLI care if the "autolinking" configuration is set to only support iOS? In other words, if we set the library to only "autolink" on the iOS platform, will the project importing the library ignore the "codegen" for android side, and not compile it.


---

<br><br>

## For Next Major Version

- [ ] **Cleanup**: <u>Breaking Change</u> — Remove legacy support for icon config shorthand/shortcut that was added temporarily when migrating between an older version of this library.
- [ ] **Refactor**: `findNodeHandle` has been deprecated due to fabric support.

---

<br><br>

## WIP

------

<br><br>

## Completed

### Version: `next`