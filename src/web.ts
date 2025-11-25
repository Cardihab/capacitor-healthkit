/* eslint-disable @typescript-eslint/no-unused-vars */
import { WebPlugin } from '@capacitor/core';

import type {
  EditionQuery,
  AuthorizationQueryOptions,
  CapacitorHealthkitPlugin,
  MultipleQueryOptions,
  SingleQueryOptions,
  AnchoredQueryOptions,
  AggregatedQueryOptions,
  AnchoredAggregatedQueryOptions,
  QueryOutput,
  AnchoredQueryOutput,
  AggregatedQueryOutput,
  AnchoredAggregatedQueryOutput,
  MultipleEditionQuery,
} from './definitions';

export class CapacitorHealthkitWeb
  extends WebPlugin
  implements CapacitorHealthkitPlugin {
  async requestAuthorization(
    _authOptions: AuthorizationQueryOptions,
  ): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async queryHKitSampleType<T>(_queryOptions: SingleQueryOptions): Promise<QueryOutput<T>> {
    throw this.unimplemented('Not implemented on web.');
  }

  async queryHKitSampleTypeAnchored<T>(_queryOptions: AnchoredQueryOptions): Promise<AnchoredQueryOutput<T>> {
    throw this.unimplemented('Not implemented on web.');
  }

  async isAvailable(): Promise<{ available: boolean }> {
    throw this.unimplemented('Not implemented on web.');
  }

  async multipleQueryHKitSampleType(
    _queryOptions: MultipleQueryOptions,
  ): Promise<any> {
    throw this.unimplemented('Not implemented on web.');
  }

  async isEditionAuthorized(_queryOptions: EditionQuery): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async multipleIsEditionAuthorized(_queryOptions: MultipleEditionQuery): Promise<void> {
    throw this.unimplemented('Not implemented on web.');
  }

  async queryAggregatedDailySampleType(_options: AggregatedQueryOptions): Promise<AggregatedQueryOutput> {
    throw this.unimplemented('Not implemented on web.');
  }

  async queryAggregatedDailySampleTypeAnchored(_options: AnchoredAggregatedQueryOptions): Promise<AnchoredAggregatedQueryOutput> {
    throw this.unimplemented('Not implemented on web.');
  }
}