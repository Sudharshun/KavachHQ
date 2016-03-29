/*
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License. You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License
 * is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
 * or implied. See the License for the specific language governing permissions and limitations under
 * the License.
 */
/*
 * This code was generated by https://code.google.com/p/google-apis-client-generator/
 * (build: 2016-02-18 22:11:37 UTC)
 * on 2016-03-27 at 08:37:58 UTC 
 * Modify at your own risk.
 */

package com.appspot.kavachhq.garudaapi.model;

/**
 * Model definition for Container.
 *
 * <p> This is the Java data model class that specifies how to parse/serialize into the JSON that is
 * transmitted over HTTP when working with the garudaapi. For a detailed explanation see:
 * <a href="http://code.google.com/p/google-http-java-client/wiki/JSON">http://code.google.com/p/google-http-java-client/wiki/JSON</a>
 * </p>
 *
 * @author Google, Inc.
 */
@SuppressWarnings("javadoc")
public final class Container extends com.google.api.client.json.GenericJson {

  /**
   * The value may be {@code null}.
   */
  @com.google.api.client.util.Key("Text")
  private java.lang.String text;

  /**
   * @return value or {@code null} for none
   */
  public java.lang.String getText() {
    return text;
  }

  /**
   * @param text text or {@code null} for none
   */
  public Container setText(java.lang.String text) {
    this.text = text;
    return this;
  }

  @Override
  public Container set(String fieldName, Object value) {
    return (Container) super.set(fieldName, value);
  }

  @Override
  public Container clone() {
    return (Container) super.clone();
  }

}
